//
//  NavDestinationModifier.swift
//  ZMangas
//
//  Created by Miguel Gallego on 14/2/24.
//

import SwiftUI

struct NavDestinationModifier: ViewModifier {
    let sideItem: SideItem
    
    func body(content: Content) -> some View {
        if isIPad() {
            content.modifier(EmptyModifier())
        } else {
            switch sideItem {
            case .mangas, .bestMangas:
                content.navigationDestination(for: Manga.self) { manga in
                    DetailView(manga: manga)
                }
            case .myCollection:
                content.navigationDestination(for: Manga.self) { manga in  // TODO:
                    DetailView(manga: manga)
                }
            }
        }
    }
}

struct SelectMangaForIPadModifier: ViewModifier {
    @EnvironmentObject var mangasVM: MangasVM
    
    let manga: Manga?
    
    func body(content: Content) -> some View {
        if isIPad() {
            content.onTapGesture {
                mangasVM.selectedMangaForIPad = manga
            }
        } else {
            content.modifier(EmptyModifier())
        }
    }
}
