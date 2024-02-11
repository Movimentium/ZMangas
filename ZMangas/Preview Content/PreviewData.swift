//
//  PreviewData.swift
//  ZMangas
//
//  Created by Miguel Gallego on 7/2/24.
//

import Foundation

struct PreviewInteractor: DataInteractor {

    let akiraURL = Bundle.main.url(forResource: "Akira", withExtension: "json")!
    let mangasURL = Bundle.main.url(forResource: "Mangas100", withExtension: "json")!
    let bestMangasURL = Bundle.main.url(forResource: "BestMangas100", withExtension: "json")!
    let authorsURL = Bundle.main.url(forResource: "Authors", withExtension: "json")!
    let themesURL = Bundle.main.url(forResource: "Themes", withExtension: "json")!
    let genresURL = Bundle.main.url(forResource: "Genres", withExtension: "json")!

    
    func loadTestJSON<T:Codable>(url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // MARK: - DataInteractor methods
    func getMangaPage(_ page: Int) async throws -> MangaPage {
        let dtoMangaPage: DTOMangaPage = try loadTestJSON(url: mangasURL)
        return dtoMangaPage.toModel
    }
    
    func getMangas(beginsWith str: String) async throws -> [Manga] {
        try await getMangaPage(1).items.filter { $0.title.starts(with: str) }
    }
    
    func getMangas(contains str: String, page: Int) async throws -> MangaPage {
        try await getMangaPage(1)
    }
    
    func getManga(id: String) async throws -> Manga {
        getAkira()
    }
    
    func getMangas(by filter: FilterBy, item: String, page: Int) async throws -> MangaPage {
        let dtoMangaPage: DTOMangaPage = try loadTestJSON(url: mangasURL)
        return switch filter {
        case .genre:
            MangaPage(items: dtoMangaPage.items.map(\.toModel).filter { $0.genres.contains { $0.genre == item }},
                      metadata: dtoMangaPage.metadata.toModel)
        case .theme:
            MangaPage(items: dtoMangaPage.items.map(\.toModel).filter { $0.themes.contains { $0.theme == item }},
                      metadata: dtoMangaPage.metadata.toModel)
        case .demographic:
            MangaPage(items: dtoMangaPage.items.map(\.toModel).filter { $0.demographics.contains { $0.demographic == item }},
                      metadata: dtoMangaPage.metadata.toModel)
        case .author:
            MangaPage(items: dtoMangaPage.items.map(\.toModel).filter { $0.authors.contains { $0.id.uuidString == item }},
                      metadata: dtoMangaPage.metadata.toModel)
        }
    }
    
    
    
    
    func getAuthors(by str: String) async throws -> [Author] {
        try await getAuthors().filter{ $0.fullName.contains(str) || $0.lastName.contains(str) }
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
    
    func getAkira() -> Manga {
        let dtoManga: DTOManga = try! loadTestJSON(url: akiraURL)
        return dtoManga.toModel
    }
}

extension MangasVM {
    static let preview = MangasVM(interactor: PreviewInteractor())
}

extension SearchVM {
    static let preview = SearchVM(interactor: PreviewInteractor())
}

extension Manga {
    static let akira = PreviewInteractor().getAkira()
}

extension URL {
    static let akiraCoverURL = URL(string: "https://cdn.myanimelist.net/images/manga/3/271629l.jpg")!
}
