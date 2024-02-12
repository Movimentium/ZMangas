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
    
    var myMangas: Set<Manga> = []
    
    init(interactor: DataInteractor = Network()) {
        print(Self.self, #function)
        self.interactor = interactor
        do {
            let container = try ModelContainer(for: DBManga.self)
            context = ModelContext(container)
            try getMisMangas()
        } catch {
            print(error)
            fatalError("Error al obtener la DB")
        }
    }
    
    private var setIds: Set<Int> = [] {
        didSet {
            print(setIds)
        }
    }
    
    func isInMyDB(id: Int) -> Bool {
        setIds.contains(id)
    }
    
    func getMisMangas() throws {
        print(Self.self, #function)

        var query = FetchDescriptor<DBManga>()
        let items = try context.fetch(query)
        print("items: \(items)")
//        items.forEach { print($0) }
    }
    
    func addManga(_ manga: Manga) {
        print(Self.self, #function)
 
        // si no existe añadir
        let newDBManga = DBManga(id: manga.id)
        context.insert(newDBManga)
        let _ = try? context.save()
        myMangas.insert(manga)
        setIds.insert(manga.id)
        objectWillChange.send()
    }

    
    // delete manga
    
    
    
}
