//
//  MangasView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import SwiftUI

struct MangasView: View {
    @EnvironmentObject var vm: MangasVM
    @EnvironmentObject var searchVM: SearchVM

    @State private var isGridMode = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isGridMode {
                    MangasGrid(mangas: $vm.mangas,
                               onAppearFunc: vm.loadNextPageIfNeeded)
                } else {
                    MangasList(mangas: $vm.mangas,
                               onAppearFunc: vm.loadNextPageIfNeeded)
                }
            }
            .navigationTitle("Mangas")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Manga.self) { manga in
                DetailView(manga: manga)
            }
            .refreshable {
                vm.getMangas(resetting: true)
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
        } //NavStack
        .sheet(isPresented: $searchVM.showFilter) {
            FilterView()
        }
        .alert("Alerta", isPresented: $vm.showAlert) { } message: {
            Text(vm.alertMsg)
        }

      
    }
}

#Preview {
    MangasView()
//        .environmentObject(MangasVM())
//        .environmentObject(SearchVM())
        .environmentObject(MangasVM.preview)
        .environmentObject(SearchVM.preview)
        .environmentObject(MyMangasVM())

}
