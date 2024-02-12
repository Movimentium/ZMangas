//
//  BestMangasView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 9/2/24.
//

import SwiftUI

struct BestMangasView: View {
    @EnvironmentObject var vm: BestMangasVM
    @State private var isGridMode = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isGridMode {
                    MangasGrid(mangas: $vm.bestMangas,
                               onAppearFunc: vm.loadNextPageIfNeeded)
                } else {
                    MangasList(mangas: $vm.bestMangas,
                               onAppearFunc: vm.loadNextPageIfNeeded)
                }
            }
            .navigationTitle("Best Mangas")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Manga.self) { manga in
                DetailView(manga: manga)
            }
            .refreshable {
                vm.getBestMangas()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isGridMode.toggle()
                    } label: {
                        Image(systemName: isGridMode ? "rectangle.grid.1x2" : "square.grid.2x2")
                    }
                }
            } //.toolbar
        } //NavStack
        .alert("Alerta", isPresented: $vm.showAlert) { } message: {
            Text(vm.alertMsg)
        }
    }
}

#Preview {
    BestMangasView()
//        .environmentObject(BestMangasVM())
        .environmentObject(BestMangasVM.preview)

}
