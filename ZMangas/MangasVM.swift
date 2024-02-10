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
    private var metaData = MetaData(total: 0, page: 0, per: 0)
    
    private var page = 1
    @Published var isLoadingData = false
    
    init(interactor: DataInteractor = Network()) {
        self.interactor = interactor
        getMangas()
    }
    
    private func reset() {
        mangas = []
        page = 1
    }
    
    func loadNextPageIfNeeded(manga: Manga) {
        if mangas.last?.id == manga.id && !isLoadingData {
            isLoadingData = true
            page += 1
            Task {
                if isFilterActive {
                    await getMangaPageBy()
                } else {
                    await getMangaPage()
                }
            }
        }
    }
    
    private func todo() {
        let remaining = metaData.total - metaData.page * metaData.per
        print("remaining: ", remaining)
    }
    
    // MARK: - Mangas ==============================================================
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
                mangas += mangaPage.items
                isLoadingData = false
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Manga By ===========================================================
    @Published var isFilterActive = false
    private(set) var filterBy: FilterBy = .genre
    private(set) var filterItem = ""
    
    func getMangas(by filter: FilterBy, item: String) {
        isFilterActive = true
        filterBy = filter
        filterItem = item
        reset()
        Task {
            await getMangaPageBy()
        }
    }
    
    func getMangaPageBy() async {
        do {
            let mangaPage = try await interactor.getMangas(by: filterBy, item: filterItem, page: page)
            await MainActor.run {
                mangas += mangaPage.items
                metaData = mangaPage.metadata
                isLoadingData = false
            }
        } catch {
            print(error)
            //isFilterActive = false
        }
    }
}
