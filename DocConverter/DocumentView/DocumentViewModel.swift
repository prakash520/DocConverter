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
    
    func isDocumentNameValid(_ name: String) -> Bool {
        return !CoreDataManager.shared.fetchAllDocumentNames().contains(name)
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
    
    func generatePDF() {
        let pdfDocument = PDFDocument()
        var pageIndex = 0

        // A4 page dimensions in points
        let a4PageWidth: CGFloat = 595
        let a4PageHeight: CGFloat = 842

        // Margins in points
        let margin: CGFloat = 36 // Half an inch (0.5 inch)
        let contentWidth = a4PageWidth - 2 * margin
        let contentHeight = a4PageHeight - 2 * margin

        for item in items {
            if case .images(let image) = item {
                // Define the drawing area with margins
                let imageBounds = CGRect(x: margin, y: margin, width: contentWidth, height: contentHeight)
                
                // Create a scaled image to fit within the content area
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: a4PageWidth, height: a4PageHeight))
                let pageImage = renderer.image { context in
                    // Fill the page background with white
                    UIColor.white.setFill()
                    context.fill(CGRect(x: 0, y: 0, width: a4PageWidth, height: a4PageHeight))
                    
                    // Draw the image in the defined bounds
                    image.draw(in: imageBounds)
                }

                // Create a PDFPage from the rendered image
                if let pdfPage = PDFPage(image: pageImage) {
                    pdfDocument.insert(pdfPage, at: pageIndex)
                    pageIndex += 1
                }
            }
        }

        // Save PDF to a temporary URL
        let temporaryURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(getDocumentName()).pdf")
        if pdfDocument.write(to: temporaryURL) {
            pdfURL = temporaryURL
        } else {
            pdfURL = nil
        }
    }

    
    private func getDocumentName() -> String {
        documentName.isEmpty ? "Untitled": documentName
    }
}
