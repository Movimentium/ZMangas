//
//  ContentView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = MangasVM()
    
    var body: some View {
        List(vm.mangas) { manga in
            Text(manga.title)
        }
    }
}

#Preview {
    ContentView()
}
