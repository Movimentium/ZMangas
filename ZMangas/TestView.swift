//
//  TestView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 7/2/24.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var vm: SearchVM
    
    
    var sections = ["Demografías", "Generos", "Temas", "Autores"]
    
    var body: some View {
        List {
            Section {
                ForEach(vm.demographics, id: \.self) { item in
                    Text(item)
                }
            } header: {
                Text(sections[0])
            }
            Section {
                ForEach(vm.genres, id: \.hashValue) { item in
                    Text(item)
                }
            } header: {
                Text(sections[1])
            }
            Section {
                ForEach(vm.themes, id: \.hashValue) { item in
                    Text(item)
                }
            } header: {
                Text(sections[2])
            }
            Section {
                ForEach(vm.authors) { item in
                    Text("\(item.lastName), \(item.firstName)")
                }
            } header: {
                Text(sections[3])
            }
        }
      
    }
}

#Preview {
    TestView()
//        .environmentObject(MangasVM())
//        .environmentObject(MangasVM.preview)
        .environmentObject(SearchVM())
}
