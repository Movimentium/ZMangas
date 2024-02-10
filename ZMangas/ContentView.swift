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
    
    var body: some View {
        NavigationStack {
            List(vm.mangas) { manga in
                NavigationLink(value: manga) {
                    MangaRowView(manga: manga)
                }
                .onAppear {
                    vm.loadNextPageIfNeeded(manga: manga)
                }
            }
            .navigationTitle("Mangas")
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
                        
                    }
                }
            }
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
