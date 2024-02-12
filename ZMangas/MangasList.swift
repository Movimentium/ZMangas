//
//  MangasList.swift
//  ZMangas
//
//  Created by Miguel Gallego on 11/2/24.
//

import SwiftUI

struct MangasList: View {
    @Binding var mangas: [Manga]
    var onAppearNewMangaFunc: ((Manga) -> Void)?
    var addToMyCollectionFunc: ((Manga) -> Void)?
    
    var body: some View {
        List(mangas) { manga in
            MangaRowView(manga: manga)
            .contextMenu {
                Button("Añadir a mi colección", systemImage: "heart.fill") {
                    addToMyCollectionFunc?(manga)
                }
            }   
            .onAppear {
                onAppearNewMangaFunc?(manga)
            }
        }
    }
}

#Preview {
    MangasList(mangas: .constant(PreviewInteractor().mangas100Test))
}
