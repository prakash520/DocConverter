//
//  DocumentViewModel.swift
//  DocConverter
//
//  Created by Prakash Kumar on 08/11/24.
//

import SwiftUI
import PDFKit

final class DocumentViewModel: ObservableObject {
    
    @Published var items: [DocumentModelType] 
    @Published var selectedImage: UIImage?
    @Published var documentName: String
    @Published var pdfURL: URL?
    
    var canCreatePDF: Bool {
        items.contains(where: {
            if case .images = $0 {
                return true
            }
            return false
        })
    }
    
    init(items: [DocumentModelType] = [.add],
         documentName: String = "") {
        self.items = items
        self.documentName = documentName
        fetchImages()
    }
    
    func addImage(_ image: UIImage) {
        items.append(.images(image))
    }
    
    
    func fetchImages() {
        items = [.add]
        
        let documents = CoreDataManager.shared.fetchAllDocuments()
        let document = documents.first { $0.name == documentName }
        
        guard let document else { return }
        let images = CoreDataManager.shared.fetchImages(for: document)
        for image in images {
            items.append(.images(image))
        }
    }
    
    func clearCache() {
        let documents = CoreDataManager.shared.fetchAllDocuments()
        let document = documents.first { $0.name == documentName }
        
        guard let document else { return }
        
        CoreDataManager.shared.deleteDocument(document)
    }
    
    func saveImage() {
        
        let images = items.compactMap { item -> UIImage? in
            if case .images(let image) = item {
                return image
            }
            return nil
        }
        clearCache()
        CoreDataManager.shared.saveDocumentWithImages(documentName: documentName, images: images)
    }
    
    func generatePDF()  {
        let pdfDocument = PDFDocument()
        var pageIndex = 0
        
        for item in items {
            if case .images(let image) = item {
                if let pdfPage = PDFPage(image: image) {
                    pdfDocument.insert(pdfPage, at: pageIndex)
                    pageIndex += 1
                }
            }
        }
        
        let temporaryURL = FileManager.default.temporaryDirectory.appendingPathComponent("Document.pdf")
        if pdfDocument.write(to: temporaryURL) {
            pdfURL = temporaryURL
        } else {
            pdfURL = nil
        }
    }
}
