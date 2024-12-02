//
//  CoreDataManager.swift
//  DocConverter
//
//  Created by Prakash Kumar on 02/12/24.
//

import Foundation
import CoreData
import UIKit
import SwiftUICore

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "docConverter") // Replace with your .xcdatamodeld file name
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loading persistent stores: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Save Document with Images
    func saveDocumentWithImages(documentName: String, images: [UIImage]) {
        let document = Doc(context: context)
        document.id = UUID()
        document.name = documentName
        document.creationDate = Date()
        
        for image in images {
            guard let imageData = image.pngData() else {
                print("Failed to convert UIImage to data")
                continue
            }
            
            let imageEntity = DocImage(context: context)
            imageEntity.id = UUID()
            imageEntity.data = imageData
            imageEntity.creationDate = Date()
            imageEntity.document = document
        }
        
        saveContext()
    }
    
    // MARK: - Fetch All Documents
    func fetchAllDocuments() -> [Doc] {
        let fetchRequest: NSFetchRequest<Doc> = Doc.fetchRequest()
        
        do {
            let documents = try context.fetch(fetchRequest)
            return documents
        } catch {
            print("Failed to fetch documents: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Fetch Images for a Specific Document
    func fetchImages(for document: Doc) -> [UIImage] {
        guard let imageEntities = document.images else { return [] }
        return imageEntities
            .compactMap { ($0 as AnyObject).data }
            .compactMap { UIImage(data: $0) }
    }

    // MARK: - Delete a Specific Document
    func deleteDocument(_ document: Doc) {
        context.delete(document)
        saveContext()
    }
    
    // MARK: - Save Context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Context saved successfully.")
            } catch {
                print("Failed to save context: \(error.localizedDescription)")
            }
        }
    }
}
