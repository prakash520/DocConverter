//
//  DocumentView.swift
//  DocConverter
//
//  Created by Prakash Kumar on 07/11/24.
//

import SwiftUI

struct DocumentView: View {
    
    @ObservedObject var viewModel: DocumentViewModel
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let width = ((UIScreen.main.bounds.width) / 2 - 70)
    
    @State private var isShowingShareSheet = false
    @State private var isShowingNameSheet = false
    @State private var pdfURL: URL?
    @State private var newDocumentName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    if viewModel.documentName.isEmpty {
                        isShowingNameSheet = true
                    } else {
                        viewModel.saveImage()
                    }
                }){
                    Image(systemName: "square.and.arrow.down")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(viewModel.canCreatePDF ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!viewModel.canCreatePDF)
                .padding(.trailing, 20)
                
                Button(action: {
                    pdfURL = viewModel.createPDF()
                    if pdfURL != nil {
                        isShowingShareSheet = true
                    }
                }) {
                    Image(systemName: "doc.text")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(viewModel.canCreatePDF ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!viewModel.canCreatePDF)
                .padding(.trailing, 24)
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.items, id: \.self) { item in
                        switch item {
                        case .add:
                            ImagePickerWithActionSheet(selectedImage: $viewModel.selectedImage, width: width)
                        case .images(let image):
                            DocumentPreviewView(width: width, image: image)
                                .padding()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onChange(of: viewModel.selectedImage) { newImage in
            if let image = newImage {
                viewModel.addImage(image)
            }
        }
        .sheet(isPresented: $isShowingShareSheet) {
            if let url = pdfURL {
                ShareSheet(activityItems: [url]) {
                    // Remove the shared file after sharing
                    try? FileManager.default.removeItem(at: url)
                    print("Temporary file deleted.")
                }
            }
        }
        .sheet(isPresented: $isShowingNameSheet) {
            VStack {
                Text("Enter Document Name")
                    .font(.headline)
                    .padding()
                
                TextField("Document Name", text: $newDocumentName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Save") {
                    viewModel.documentName = newDocumentName
                    viewModel.saveImage()
                    isShowingNameSheet = false
                }
                .disabled(newDocumentName.isEmpty)
                .padding()
                .background(newDocumentName.isEmpty ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
    }
}

#Preview {
    DocumentView(viewModel: DocumentViewModel(items: [.add]))
}
