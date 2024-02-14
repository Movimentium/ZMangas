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
            .modifier(NavDestinationModifier(sideItem: .mangas))
            .refreshable {
                vm.getMangas(resetting: true)
            }
            .modifier(ToolBarMangas(isGridMode: $isGridMode))
        } //NavStack
        .sheet(isPresented: $searchVM.showFilter) {
            FilterView()
        }
        .sheet(isPresented: $searchVM.showSearch) {
            SearchView()
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
