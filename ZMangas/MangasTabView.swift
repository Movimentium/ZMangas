//
//  MangasTabView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 9/2/24.
//

import SwiftUI

struct MangasTabView: View {
    var body: some View {
        TabView {
            MangasView()
                .tabItem {
                    Label("Mangas", systemImage: "list.star")
                }
            BestMangasView()
                .tabItem {
                    Label("Best Mangas", systemImage: "star.fill")
                }
            MyMangasView()
                .tabItem {
                    Label("Mi colección", systemImage: "books.vertical")
                }
        }
        
    }
}

#Preview {
    MangasTabView()
        .environmentObject(MangasVM.preview)
        .environmentObject(SearchVM.preview)
        .environmentObject(BestMangasVM.preview)
}
