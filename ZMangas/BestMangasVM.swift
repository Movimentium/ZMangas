//
//  BestMangasVM.swift
//  ZMangas
//
//  Created by Miguel Gallego on 12/2/24.
//

import Foundation

final class BestMangasVM: ObservableObject {
    let interactor: DataInteractor
    
    @Published var bestMangas: [Manga] = []
    private var metaData = MetaData(total: 0, page: 0, per: 0)
    
    private var page = 1
    private var isLoadingData = false
    
    init(interactor: DataInteractor = Network()) {
        self.interactor = interactor
        getBestMangas()
    }
    
    private func getBestMangas() {
        page = 0
        bestMangas = []
        Task {
            await getMangaPage()
        }
    }
    
    private func getMangaPage() async {
        do {
            let mangaPage = try await interactor.getBestMangas(page: page)
            await MainActor.run {
                bestMangas += mangaPage.items
                metaData = mangaPage.metadata
                isLoadingData = false
            }
        } catch {
            print(error)
        }
    }
    
    private var remainingMangas: Int {
        let remaining = metaData.total - metaData.page * metaData.per
        print("\nremaining: ", remaining);  print(metaData)
        return remaining
    }

    func loadNextPageIfNeeded(manga: Manga) {
        if bestMangas.last?.id == manga.id && !isLoadingData && remainingMangas > 0 {
            isLoadingData = true
            page += 1
            Task { await getMangaPage() }
        }
    }
}
