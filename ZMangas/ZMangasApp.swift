//
//  ZMangasApp.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import SwiftUI

@main
struct ZMangasApp: App {
    @StateObject var vm = MangasVM()  //No muevas esto de aquí
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .onAppear {
                    print("Int.max: \(Int.max)")
                    print(URL.mangas)
                    print(URL.mangas(page: 2))
                    print(URL.mangas())
                    print(URL.mangas(by: .genre, item: "romance"))
                    print(URL.mangas(by: .genre, item: "romance", page: 2))
                }
        }
    }
}
