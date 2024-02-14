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
    var selectedMangaForIPad: Manga? 
    private var metaData = MetaData.zero
    
    private var page = 1
    private var isLoadingData = false
    
    init(interactor: DataInteractor = Network()) {
        self.interactor = interactor
        getMangas()
    }
    
    private func reset() {
        mangas = []
        page = 1
        isFilterActive = false
        isSearchActive = false
    }
    
    func loadNextPageIfNeeded(manga: Manga) {
        if mangas.last?.id == manga.id && !isLoadingData && remainingMangas > 0 {
            isLoadingData = true
            page += 1
            Task {
                if isFilterActive {
                    await getMangaByPage()
                } else if isSearchActive && searchTitleType == .contains {
                    await getMangaSearchingTitleContainsPage()
                } else if !isSearchActive {
                    await getMangaPage()
                }
            }
        }
    }
    
    private var remainingMangas: Int {
        let remaining = metaData.total - metaData.page * metaData.per
        print("\nremaining: ", remaining);  print(metaData)
        return remaining
    }
    
    // MARK: - Mangas ==============================================================
    func getMangas(resetting: Bool = false) {
        if resetting {
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
                metaData = mangaPage.metadata
                isLoadingData = false
            }
        } catch {
            await errorsHandle(error)
            print(error)
        }
    }
    
    // MARK: - Manga By ===========================================================
    @Published var isFilterActive = false
    private(set) var filterBy: FilterBy = .genre
    private(set) var filterItem = ""
    
    func getMangas(by filter: FilterBy, item: String) {
        filterBy = filter
        filterItem = item
        reset()
        Task {
            await getMangaByPage()
        }
    }
    
    func getMangaByPage() async {
        do {
            let mangaByPage = try await interactor.getMangas(by: filterBy, item: filterItem, page: page)
            await MainActor.run {
                mangas += mangaByPage.items
                metaData = mangaByPage.metadata
                isLoadingData = false
                isFilterActive = true
            }
        } catch {
            await errorsHandle(error)
            print(error)
        }
    }
    
    // MARK: - Search Title ===========================================================
    @Published var isSearchActive = false
    private(set) var searchTitleType: SearchType = .begins
    private(set) var searchItem = ""
    
    func getMangasTitles(searchType: SearchType, item: String) {
        searchTitleType = searchType
        searchItem = item
        reset()
        Task {
            if searchType == .contains {
                await getMangaSearchingTitleContainsPage()
            } else {  // searchType == .begins
                await getMangasSearchingTitlenBegins()
            }
        }
    }
    
    // .contains is Paginated, .begins NOT
    func getMangaSearchingTitleContainsPage() async {
        do {
            let mangaSearchPage = try await interactor.getMangas(contains: searchItem, page: page)
            await MainActor.run {
                mangas += mangaSearchPage.items
                metaData = mangaSearchPage.metadata
                isLoadingData = false
                isSearchActive = true
            }
        } catch {
            await errorsHandle(error)
            print(error)
        }
    }
    
    func getMangasSearchingTitlenBegins() async {
        do {
            let mangasBeginsWith = try await interactor.getMangas(beginsWith: searchItem)
            await MainActor.run {
                mangas = mangasBeginsWith
                isSearchActive = true
            }
        } catch {
            await errorsHandle(error)
            print(error)
        }
    }
    
    // MARK: - Errors Handle ===========================================================
    @Published var showAlert = false
    @Published var alertMsg = ""
    
    private func errorsHandle(_ error: Error) async {
        await MainActor.run {
            alertMsg = "\(error)"
            showAlert = true
        }
    }
}
