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
            ContentView()
                .tabItem {
                    Label("Mangas", systemImage: "list.star")
                }
//            /*BestMangasView*/()
            GridView()
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
}
