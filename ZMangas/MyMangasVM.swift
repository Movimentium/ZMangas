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
    
    @Published var myMangas: [MyManga] = []
    private var setOfIds: Set<Int> = [] {
        didSet {
            print(setOfIds)
        }
    }

    init(interactor: DataInteractor = Network()) {
        print(Self.self, #function)
        self.interactor = interactor
        do {
            let container = try ModelContainer(for: DBManga.self)
            context = ModelContext(container)
            context.autosaveEnabled = true
            try getMyMangas()
        } catch {
            print(error)
            fatalError("Error al obtener la DB")
        }
    }

    func isInMyDB(id: Int) -> Bool {
        setOfIds.contains(id)
    }
        
    func getMyMangas() throws {
        print(Self.self, #function)
        myMangas = []
        let query = FetchDescriptor<DBManga>()
        let dbMangas = try context.fetch(query)
        print("items: ")
        dbMangas.forEach {
            print($0)
            setOfIds.insert($0.id)
        }
        Task {
            await getMangasByIds(for: dbMangas)
        }
    }
    
    func addManga(_ manga: Manga, ctx: ModelContext) {
        print(Self.self, #function)
 
        let newDBManga = DBManga(id: manga.id)
        ctx.insert(newDBManga)
        let myManga = MyManga(manga: manga, dbManga: newDBManga)
        myMangas.append(myManga)
        setOfIds.insert(manga.id)
    }
    
    func deleteManga(_ myManga: MyManga) {
        print(Self.self, #function)
        let mangaId = myManga.id
        
        var query = FetchDescriptor<DBManga>()
        query.predicate = #Predicate { $0.id == mangaId }
        if let mangaToDelete = try? context.fetch(query).first {
            print(mangaToDelete)
            myMangas.removeAll { $0.id == mangaId }
            context.delete(mangaToDelete)
            setOfIds.remove(mangaId)
        } else {
            print("Error en al borrar")
        }
    }

    
    private func getMangasByIds(for dbMangas: [DBManga]) async {
        do {
            for dbManga in dbMangas {
                let id = "\(dbManga.id)"
                let manga = try await interactor.getManga(id: id)
                await MainActor.run {
                    let myManga = MyManga(manga: manga, dbManga: dbManga)
                    self.myMangas.append(myManga)
                }
            }
        } catch {
            print(error)
        }
    }
    
}
