//
//  MyMangasView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 9/2/24.
//

import SwiftUI

struct MyMangasView: View {
    @EnvironmentObject var vm: MyMangasVM

    var body: some View {
        NavigationStack {
            MangasList(mangas: $vm.myMangas)
            .navigationTitle("Mis Mangas")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Manga.self) { manga in
                DetailView(manga: manga)
            }
        } //NavStack
    }
}

#Preview {
    MyMangasView()
}
