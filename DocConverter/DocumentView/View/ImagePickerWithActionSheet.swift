//
//  ImagePickerWithActionSheet.swift
//  DocConverter
//
//  Created by Prakash Kumar on 12/11/24.
//

import SwiftUI
import UIKit

struct ImagePickerWithActionSheet: View {
    @Binding var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showActionSheet = false
    var width: CGFloat

    var body: some View {
        Button(action: {
            showActionSheet = true
        }) {
            DocumentAddView(width: width) // Use DocumentAddView here as the button content
                .padding()
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("Choose Image Source"), buttons: [
                .default(Text("Camera")) {
                    sourceType = .camera
                    isShowingImagePicker = true
                },
                .default(Text("Photo Library")) {
                    sourceType = .photoLibrary
                    isShowingImagePicker = true
                },
                .cancel()
            ])
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
        }
    }
}
