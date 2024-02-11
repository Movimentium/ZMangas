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
    
    var body: some View {
        List(mangas) { manga in
            NavigationLink(value: manga) {
                MangaRowView(manga: manga)
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
