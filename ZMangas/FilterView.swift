//
//  FilterView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 8/2/24.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var mangasVM: MangasVM
    @EnvironmentObject var vm: SearchVM
    
    @State var showSearchBar = false

    var body: some View {    
        NavigationStack {
            VStack {
                Picker("Filtro", selection: $vm.filterBy) {
                    ForEach(FilterBy.allCases, id: \.self) { filterBy in
                        Text(filterBy.name)
                            .tag(filterBy.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                if vm.filterBy != .author {
                    List(vm.arrayToShow, id: \.self, selection: $vm.selectedItem) { item in
                        Text(item)
                    }
                } else {
                        List(vm.authorsFiltered, selection: $vm.selectedAuthorID) { author in
                            Text(author.fullName)
                        }
                        .searchable(text: $vm.searchAuthorInList, isPresented: $showSearchBar,
                                    placement: .automatic, prompt: "Buscar autor en la lista")
                        .onSubmit(of: .search) {
                            showSearchBar = false
                        }
                }
            }
            .navigationTitle("Filtrar por")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        vm.showFilter = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Aplicar") {
                        if vm.isValidSelection {
                            mangasVM.getMangas(by: vm.filterBy,
                                               item: vm.itemToFilter)
                        }
                    }
                }
            } //.toolbar
        }
    }
}

#Preview {
    NavigationStack {
        FilterView()
            .environmentObject(MangasVM.preview)
            .environmentObject(SearchVM())
    }
}
