//
//  MangasGrid.swift
//  ZMangas
//
//  Created by Miguel Gallego on 11/2/24.
//

import SwiftUI

struct MangasGrid: View {
    @Binding var mangas: [Manga]
    var onAppearNewMangaFunc: ((Manga) -> Void)?
    
    private let gridItem = GridItem(.adaptive(minimum: 150))
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [gridItem]) {
                ForEach(mangas) { manga in
                    VStack(alignment: .center) {
                        BookCoverView(coverURL: manga.coverURL, mode: .grid)
                        Text(manga.title)
                            .font(.headline)
                    }
                    .onAppear {
                        onAppearNewMangaFunc?(manga)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    MangasList(mangas: .constant(PreviewInteractor().mangas100Test))
}
