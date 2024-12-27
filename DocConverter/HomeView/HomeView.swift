//
//  HomeView.swift
//  DocConverter
//
//  Created by Prakash Kumar on 02/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    // Define grid layout
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var isNavigatingToNewDocument: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.documents.isEmpty {
                    Text("No documents available")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.documents, id: \.self) { document in
                                NavigationLink(value: document) {
                                    DocumentCard(name: document.name ?? "Untitled")
                                }
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewModel.deleteDocument(document)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
                TabView(isNavigatingToNewDocument: $isNavigatingToNewDocument)
            }
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                viewModel.fetchDocuments()
            }
            .navigationDestination(for: Doc.self) { document in
                DocumentView(viewModel: DocumentViewModel(documentName: document.name ?? ""))
            }
            .navigationDestination(isPresented: $isNavigatingToNewDocument) {
                DocumentView(viewModel: DocumentViewModel(documentName: ""))
            }
        }
    }
}
