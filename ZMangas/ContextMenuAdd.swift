//
//  ContextMenuAdd.swift
//  ZMangas
//
//  Created by Miguel Gallego on 12/2/24.
//

import SwiftUI

struct ContextMenuAdd: ViewModifier {
    @EnvironmentObject var myMangasVM: MyMangasVM
    @Environment(\.modelContext) var context

    let manga: Manga
    
    func body(content: Content) -> some View {
        content
            .contextMenu {
                let isInMyDB = myMangasVM.isInMyDB(id: manga.id)
                let title = (isInMyDB ? "Ya está en mi colección" : "Añadir a mi colección \(manga.id)")
                Button(title, systemImage: "heart.fill") {
                    if !isInMyDB {
                        myMangasVM.addManga(manga, ctx: context)
                    }
                }
            }
    }
}
