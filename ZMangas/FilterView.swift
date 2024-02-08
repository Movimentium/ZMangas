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

    var body: some View {    
        HStack(alignment: .center) {
            Button("Cancelar", role: .cancel) {
                vm.showFilter = false
            }
            Spacer()
            Button("Aplicar") {
                vm.showFilter = false
                mangasVM.getMangas(by: vm.filterBy, 
                                   item: vm.itemToFilter)
            }
        }
        .padding()
        .overlay {
            Text("Filtrar por")
                .font(.headline)
        }
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
            List(vm.authors, selection: $vm.selectedAuthorID) { author in
                Text(author.fullName)
//                    .tag(author.id)
            }
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
