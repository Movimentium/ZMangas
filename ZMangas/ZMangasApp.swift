//
//  ZMangasApp.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import SwiftUI
import SwiftData

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
                    print(URL.documentsDirectory)
                }
        }
        .modelContainer(for: DBManga.self)
    }
}
