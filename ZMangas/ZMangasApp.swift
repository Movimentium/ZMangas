//
//  ZMangasApp.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import SwiftUI

@main
struct ZMangasApp: App {
    @StateObject var vm = MangasVM()
    @StateObject var searchVM = SearchVM()
    
    var body: some Scene {
        WindowGroup {
//            FilterView()
            ContentView()
                .environmentObject(vm)
                .environmentObject(searchVM)
                .onAppear {
                    print("Int.max: \(Int.max)")
                    print(URL.mangas)
                    print(URL.mangas(page: 2))
                    print(URL.mangas(by: .genre, item: "romance", page: 2))
                }
        }
    }
}
