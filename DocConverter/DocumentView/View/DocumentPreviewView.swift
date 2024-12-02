//
//  ImagePreviewView.swift
//  DocConverter
//
//  Created by Prakash Kumar on 07/11/24.
//

import SwiftUI

struct DocumentPreviewView: View {
    
    private let width: CGFloat
    private let image: UIImage
    
    init(width: CGFloat, image: UIImage) {
        self.width = width
        self.image = image
    }
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: 100)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    DocumentPreviewView(width: 100, image: UIImage(systemName: "highlighter") ?? UIImage())
}
