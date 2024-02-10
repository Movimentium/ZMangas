//
//  DetailView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 9/2/24.
//

import SwiftUI

struct DetailView: View {
    
    let manga: Manga
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                
            }
        }
        .padding()
        .onAppear {
            print(manga.title)
        }
    }
}
    
#Preview {
    DetailView(manga: .akira)
}
