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
                VStack(alignment: .leading) {
                    Text(manga.title)
                    Text(manga.authorsFullNames)
                        .font(.caption)
                        .foregroundStyle(.gray)
                    HStack(alignment: .top) {
                        Text(FilterBy.genre.name)
                            .font(.caption)
                            .bold()
                        Text(manga.strGenres)
                            .font(.caption)
                            .foregroundStyle(.gray)

                    }
                    HStack(alignment: .top) {
                        Text(FilterBy.theme.name)
                            .font(.caption)
                            .bold()
                        Text(manga.strThemes)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    HStack(alignment: .top) {
                        Text(FilterBy.demographic.name)
                            .font(.caption)
                            .bold()
                        Text(manga.strDemographics)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
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
        .environmentObject(MangasVM.preview)
        .environmentObject(SearchVM())
}
