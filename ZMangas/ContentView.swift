//
//  ContentView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: MangasVM
    @EnvironmentObject var searchVM: SearchVM
    @State private var isGridMode = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                    MangasGrid(mangas: $vm.mangas,
                               onAppearNewMangaFunc: vm.loadNextPageIfNeeded)
                    .opacity(isGridMode ? 1 : 0)
                    MangasList(mangas: $vm.mangas,
                              onAppearNewMangaFunc: vm.loadNextPageIfNeeded)
                    .opacity(isGridMode ? 0 : 1)

            }
            .navigationTitle("Mangas")
            .navigationDestination(for: Manga.self) { manga in
                DetailView(manga: manga)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if vm.isFilterActive {
                            vm.getMangas(resetting: true)
                        } else {
                            searchVM.showFilter = true
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .symbolVariant(vm.isFilterActive ? .fill: .none)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Buscar", systemImage: "magnifyingglass") {
                        //TODO:
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isGridMode.toggle()
                    } label: {
                        Image(systemName: isGridMode ? "rectangle.grid.1x2" : "square.grid.2x2")
                    }
                }
            } //.toolbar
        }
        .sheet(isPresented: $searchVM.showFilter) {
            FilterView()
        }
      
    }
}

#Preview {
    ContentView()
//        .environmentObject(MangasVM())
//        .environmentObject(SearchVM())
        .environmentObject(MangasVM.preview)
        .environmentObject(SearchVM.preview)
}
