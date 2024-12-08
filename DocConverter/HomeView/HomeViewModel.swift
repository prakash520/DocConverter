//
//  HomeViewModel.swift
//  DocConverter
//
//  Created by Prakash Kumar on 02/12/24.
//

import Foundation
import Combine
import UIKit

final class HomeViewModel: ObservableObject {
    @Published var documents: [Doc] = []
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
        fetchDocuments()
    }
    
    // Fetch all documents
    func fetchDocuments() {
        documents = coreDataManager.fetchAllDocuments()
    }
    
    // Delete a document
    func deleteDocument(_ document: Doc) {
        coreDataManager.deleteDocument(document)
        fetchDocuments() // Refresh the list after deletion
    }
}
