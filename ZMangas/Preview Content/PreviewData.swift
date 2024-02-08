//
//  PreviewData.swift
//  ZMangas
//
//  Created by Miguel Gallego on 7/2/24.
//

import Foundation






struct PreviewInteractor: DataInteractor {
    let mangasURL = Bundle.main.url(forResource: "BestMangas100", withExtension: "json")!
    let authorsURL = Bundle.main.url(forResource: "Authors", withExtension: "json")!
    let themesURL = Bundle.main.url(forResource: "Themes", withExtension: "json")!
    let genresURL = Bundle.main.url(forResource: "Genres", withExtension: "json")!

    
    func loadTestJSON<T:Codable>(url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func getMangaPage() async throws -> MangaPage {
        let dtoMangaPage: DTOMangaPage = try loadTestJSON(url: mangasURL)
        return dtoMangaPage.toModel
    }
    
    func getAuthors() async throws -> [Author] {
        let arrDtoAuthors: [DTOAuthor] = try loadTestJSON(url: authorsURL)
        return arrDtoAuthors.map(\.toModel)
    }
    
    func getDemographics() async throws -> [String] {
        ["Seinen", "Shounen", "Shoujo", "Josei", "Kids"]
    }
    
    func getGenres() async throws -> [String] {
        try loadTestJSON(url: genresURL)
    }
    
    func getThemes() async throws -> [String] {
        try loadTestJSON(url: themesURL)
    }
}

extension MangasVM {
    static let preview = MangasVM(interactor: PreviewInteractor())
}
