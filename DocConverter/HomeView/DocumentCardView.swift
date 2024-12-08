//
//  DocumentCardView.swift
//  DocConverter
//
//  Created by Prakash Kumar on 08/12/24.
//

import SwiftUI

struct DocumentCard: View {
    let name: String
    
    var body: some View {
        VStack {
            Image(systemName: "folder.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .padding()
            
            Text(name)
                .font(.headline)
                .lineLimit(1)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple.opacity(0.1))
                .cornerRadius(8)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
