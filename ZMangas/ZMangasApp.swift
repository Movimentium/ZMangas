//
//  ZMangasApp.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import SwiftUI

@main
struct ZMangasApp: App {
    @StateObject var myMangasVM = MyMangasVM()
    @StateObject var vm = MangasVM()
    @StateObject var searchVM = SearchVM()
    @StateObject var bestMangasVM = BestMangasVM()

    var body: some Scene {
        WindowGroup {
            MangasTabView()
                .environmentObject(vm)
                .environmentObject(searchVM)
                .environmentObject(bestMangasVM)
                .environmentObject(myMangasVM)
                .onAppear {
                    print(URL.mangas)
                    print(URL.mangas(page: 2))
                    print(URL.mangas(by: .genre, item: "romance", page: 2))
                }
        }
    }
}
