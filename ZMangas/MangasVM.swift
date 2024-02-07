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
    
    var authors: [Author] = []
    var demographics: [String] = []
    var genres: [String] = []
    var themes: [String] = []

    
    init(interactor: DataInteractor = Network()) {
        self.interactor = interactor
        Task {
            await getSearchCriteria()
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
    
    func getSearchCriteria() async {
        do {
            async let authors = interactor.getAuthors()
            async let demographics = interactor.getDemographics()
            async let genres = interactor.getGenres()
            async let themes = interactor.getThemes()
            let criteria = try await (authors, demographics, genres, themes)
            self.authors = criteria.0
            self.demographics = criteria.1
            self.genres = criteria.2
            self.themes = criteria.3
        } catch {
            print(error)
        }
    }
}
