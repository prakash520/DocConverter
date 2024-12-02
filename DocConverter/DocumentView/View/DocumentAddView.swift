//
//  AddView.swift
//  DocConverter
//
//  Created by Prakash Kumar on 07/11/24.
//

import SwiftUI

struct DocumentAddView: View {
    
    private let width: CGFloat
    
    init(width: CGFloat) {
        self.width = width
    }
    
    var body: some View {
        VStack {
            Image(systemName: "plus.circle.dashed")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: 100)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    DocumentAddView(width: 100)
}
