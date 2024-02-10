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
                HStack {
                    VStack(alignment: .center) {
                        AsyncImage(url: manga.coverURL) { cover in
                            cover.resizable()
                                .scaledToFit()
                                .frame(width: 80)
                        } placeholder: {
                            Image(systemName: "a.book.closed.ja")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .fontWeight(.ultraLight)
                        }
                        .padding(.top, 16)
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 0)
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        Text(manga.title)
                            .font(.headline)
                            .padding(.top, 4)
                        Text(manga.authorsFullNames)
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Text(FilterBy.genre.name)
                            .font(.caption)
                            .bold()
                        Text(manga.strGenres)
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Text(FilterBy.theme.name)
                            .font(.caption)
                            .bold()
                        Text(manga.strThemes)
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Text(FilterBy.demographic.name)
                            .font(.caption)
                            .bold()
                        Text(manga.strDemographics)
                            .font(.caption)
                            .foregroundStyle(.gray)
//                        Spacer()
                    }
                    .padding(.leading, 8)
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
