//
//  HomeView.swift
//  DocConverter
//
//  Created by Prakash Kumar on 02/12/24.
//

import SwiftUI
import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            Spacer()
            TabView()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TabView: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ZStack {
                Circle()
                    .foregroundColor(.purple)
                    .frame(width: 64, height: 64)
                    .shadow(color: .purple.opacity(0.4), radius: 10, x: 0, y: 5)
                
                Button(action: {
                    
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
