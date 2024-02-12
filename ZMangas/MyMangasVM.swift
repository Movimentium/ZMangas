//
//  MyMangasVM.swift
//  ZMangas
//
//  Created by Miguel Gallego on 12/2/24.
//

import Foundation
import SwiftData

final class MyMangasVM: ObservableObject {
    let interactor: DataInteractor
    let context: ModelContext
    
    @Published var myMangas: [Manga] = []
    var myDBMangas: [DBManga] = []
    
    init(interactor: DataInteractor = Network()) {
        print(Self.self, #function)
        self.interactor = interactor
        do {
            let container = try ModelContainer(for: DBManga.self)
            context = ModelContext(container)
            try getMyMangas()
        } catch {
            print(error)
            fatalError("Error al obtener la DB")
        }
    }
    
    private var setOfIds: Set<Int> = [] {
        didSet {
            print(setOfIds)
        }
    }
    
    func isInMyDB(id: Int) -> Bool {
        setOfIds.contains(id)
    }
    
    func getMyMangas() throws {
        print(Self.self, #function)

        let query = FetchDescriptor<DBManga>()
        let items = try context.fetch(query)
        print("items: ")
        items.forEach {
            print($0)
            setOfIds.insert($0.id)
        }
        Task {
            await getMangasByIds()
        }
        
    }
    
    func addManga(_ manga: Manga, ctx: ModelContext) {
        print(Self.self, #function)
 
        // si no existe añadir
        let newDBManga = DBManga(id: manga.id)
        ctx.insert(newDBManga)
//        myMangas.insert(manga)
        myMangas.append(manga)
        setOfIds.insert(manga.id)
        objectWillChange.send()
    }

    
    // delete manga
    
    private func getMangasByIds() async {
        var arrMangas: [Manga] = []
        do {
            for id in setOfIds {
                let manga = try await interactor.getManga(id: "\(id)")
                await MainActor.run {
//                    self.myMangas.insert(manga)
                    self.myMangas.append(manga)
                }
//                arrMangas.append(manga)
            }
//            await MainActor.run { [weak self] in
//                self?.myMangas = arrMangas
//            }
        } catch {
            print(error)
        }
    }
    
}
