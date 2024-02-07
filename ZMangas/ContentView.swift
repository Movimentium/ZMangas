//
//  ContentView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: MangasVM
    
    var body: some View {
        NavigationStack {
            List(vm.mangas) { manga in
                Text(manga.title)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(MangasVM())
}
