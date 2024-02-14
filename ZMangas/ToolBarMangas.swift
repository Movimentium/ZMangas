//
//  ToolBarMangas.swift
//  ZMangas
//
//  Created by Miguel Gallego on 14/2/24.
//

import SwiftUI

struct ToolBarMangas: ViewModifier {
    @EnvironmentObject var vm: MangasVM
    @EnvironmentObject var searchVM: SearchVM

    @Binding var isGridMode: Bool
    
    func body(content: Content) -> some View {
        content
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
                    Button {
                        if vm.isSearchActive {
                            vm.getMangas(resetting: true)
                        } else {
                            searchVM.showSearch = true
                        }
                    } label: {
                        Image(systemName: "magnifyingglass.circle")
                            .symbolVariant(vm.isSearchActive ? .fill: .none)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isGridMode.toggle()
                    } label: {
                        Image(systemName: isGridMode ? "rectangle.grid.1x2" : "square.grid.2x2")
                    }
                }
            }
    }
}
