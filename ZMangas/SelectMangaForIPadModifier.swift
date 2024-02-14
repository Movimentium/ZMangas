//
//  SelectMangaForIPadModifier.swift
//  ZMangas
//
//  Created by Miguel Gallego on 14/2/24.
//

import SwiftUI

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

struct SelectMyMangaForIPadModifier: ViewModifier {
    @EnvironmentObject var myMangasVM: MyMangasVM
    
    let myManga: MyManga?
    
    func body(content: Content) -> some View {
        if isIPad() {
            content.onTapGesture {
                myMangasVM.selectedMyMangaForIPad = myManga
            }
        } else {
            content.modifier(EmptyModifier())
        }
    }
}

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
                content.navigationDestination(for: MyManga.self) { myManga in
                    DetailView(manga: myManga.manga, dbManga: myManga.dbManga)
                }
            }
        }
    }
}


