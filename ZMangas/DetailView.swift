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
                Text(manga.title)
                    .font(.title)
                BookCoverView(coverURL: manga.coverURL, mode: .grid)
                
                VStack(alignment: .leading) {
                    Text(manga.authorsFullNames)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                        .border(Color.pink)
                    // genero temática, demografía
                    // score, volumes, chapters
                    if let sypnosis = manga.sypnosis {
                        Text("Sinopsis")
                            .font(.caption).bold()
                        Text(sypnosis)
                            .font(.callout).foregroundStyle(Color.black.opacity(0.8))
                    }
                    if let background = manga.background {
                        Text("Background")
                            .font(.caption).bold().padding(.top, 8)
                        Text(background)
                            .font(.callout)
                    }
                }
                .border(Color.pink)
              
            }
            .padding(.horizontal)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            print(manga.title)
        }
        
        
    }
}
    
#Preview {
    NavigationStack {
        DetailView(manga: .akira)
    }
}
