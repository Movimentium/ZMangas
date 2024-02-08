//
//  MangasVM.swift
//  ZMangas
//
//  Created by Miguel Gallego on 6/2/24.
//

import Foundation

final class MangasVM: ObservableObject {
    let interactor: DataInteractor
    
    @Published var mangas: [Manga] = []
    
    init(interactor: DataInteractor = Network()) {
        self.interactor = interactor
        Task {
            await getMangas()
        }
    }
    
    func getMangas() async {
        do {
            let mangaPage = try await interactor.getMangaPage()
            await MainActor.run {
                self.mangas = mangaPage.items
            }
        } catch {
            print(error)
        }
    }
    
    func getMangas(by: FilterBy, item: String) {
        print(Self.self, #function, by.rawValue, item)
    }
    
    
}
