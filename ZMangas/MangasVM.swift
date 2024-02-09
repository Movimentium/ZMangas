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
    @Published var isFilterActive = false
    
    private var page = 1
    
    init(interactor: DataInteractor = Network()) {
        self.interactor = interactor
        getMangas()
    }
    
    private func reset() {
        mangas = []
        page = 1
    }
    
    func getMangas(resetting: Bool = false) {
        if resetting {
            isFilterActive = false
            reset()
        }
        Task {
            await getMangaPage()
        }
    }
    
    func getMangaPage() async {
        do {
            let mangaPage = try await interactor.getMangaPage(page)
            await MainActor.run {
                self.mangas = mangaPage.items
            }
        } catch {
            print(error)
        }
    }
    
    func getMangas(by: FilterBy, item: String) {
        print(Self.self, #function, by.rawValue, item)
        reset()
        Task {
            do {
                let mangaPage = try await interactor.getMangas(by: by, item: item, page: page)
                await MainActor.run {
                    self.mangas = mangaPage.items
                    self.isFilterActive = true
                }
            } catch {
                print(error)
            }
        }
    }
    
    
}
