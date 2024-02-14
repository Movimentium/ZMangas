//
//  MangasList.swift
//  ZMangas
//
//  Created by Miguel Gallego on 11/2/24.
//

import SwiftUI

struct MangasList: View {
    @Binding var mangas: [Manga]
    var onAppearFunc: ((Manga) -> Void)?

    var body: some View {
        List(mangas) { manga in
            MangaRowView(manga: manga)
            .onAppear {
                onAppearFunc?(manga)
            }
            .modifier(ContextMenuAdd(manga: manga))
            .modifier(SelectMangaForIPadModifier(manga: manga))
        }
    }
}

#Preview {
    MangasList(mangas: .constant(PreviewInteractor().mangas100Test))
}
