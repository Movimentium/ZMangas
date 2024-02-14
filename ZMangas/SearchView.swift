//
//  SearchView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 14/2/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var mangasVM: MangasVM
    @EnvironmentObject var vm: SearchVM

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Tipo de búsqueda", selection: $vm.searchType) {
                    ForEach(SearchType.forTitle, id: \.self) { searchType in
                        Text(searchType.name)
                            .tag(searchType.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                XTextField(title: "Escribe al menos 3 caracteres",
                           placeholder: "Escribe aquí",
                           text: $vm.strSearch)
                    .padding()
                Spacer()
            }
            .navigationTitle("Buscar título")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        vm.showSearch = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Buscar") {
                        if vm.isSearchBtnEnabled {
                            vm.showSearch = false
                            mangasVM.getMangasTitles(searchType: vm.searchType,
                                                     item: vm.strSearch)
                        }
                    }
                    .opacity(vm.isSearchBtnEnabled ? 1 : 0.5)
                }
            } //.toolbar
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
            .environmentObject(MangasVM.preview)
            .environmentObject(SearchVM.preview)
    }
}
