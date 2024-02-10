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
                AsyncImage(url: manga.coverURL) { img in
                    img
                        .resizable()
                    
                } placeholder: {
                    Image(systemName: "book")
                        .resizable()
                        .scaledToFit()
                }

            }
        }
        .padding()
    }
}
    
#Preview {
    DetailView(manga: .akira)
}
