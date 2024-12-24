//
//  TabView.swift
//  DocConverter
//
//  Created by Prakash Kumar on 08/12/24.
//

import SwiftUI

struct TabView: View {
    @Binding var isNavigatingToNewDocument: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ZStack {
                Circle()
                    .foregroundColor(.purple)
                    .frame(width: 64, height: 64)
                    .shadow(color: .purple.opacity(0.4), radius: 10, x: 0, y: 5)
                
                Button(action: {
                    isNavigatingToNewDocument = true
                }) {
                    Image(systemName: "plus.app.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }
            }
            .offset(y: -20)
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.white.shadow(radius: 5))
    }
}
