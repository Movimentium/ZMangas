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
                Text(manga.title)
            }
            .navigationTitle("Mangas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Filtrar por", systemImage: "line.3.horizontal.decrease.circle") {
                        if searchVM.isFilterActive {
                            
                        } else {
                            searchVM.showFilter = true
                        }
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
        .environmentObject(MangasVM.preview)
        .environmentObject(SearchVM())
}
