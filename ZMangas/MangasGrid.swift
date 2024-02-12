//
//  MangasGrid.swift
//  ZMangas
//
//  Created by Miguel Gallego on 11/2/24.
//

import SwiftUI

struct MangasGrid: View {

    @Binding var mangas: [Manga]
    var onAppearFunc: ((Manga) -> Void)?

    private let gridItem = GridItem(.adaptive(minimum: 150))
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [gridItem]) {
                ForEach(mangas) { manga in
                    NavigationLink(value: manga) {
                        VStack(alignment: .center) {
                            BookCoverView(coverURL: manga.coverURL, mode: .grid)
                            Text(manga.title)
                                .font(.headline)
                        }
                    }
                    .buttonStyle(.plain)
                    .onAppear {
                        onAppearFunc?(manga)
                    }
                    .modifier(ContextMenuAdd(manga: manga))
                }
            }
            .padding()
        }
    }
}

#Preview {
    MangasList(mangas: .constant(PreviewInteractor().mangas100Test))
}
