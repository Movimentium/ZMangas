//
//  Network.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import Foundation

protocol DataInteractor {
    func getMangaPage(_ page: Int) async throws -> MangaPage
    func getMangas(by filter: FilterBy, item: String, page: Int) async throws -> MangaPage
    func getManga(id: String) async throws -> Manga
    func getMangas(beginsWith str: String) async throws -> [Manga]
    func getMangas(contains str: String, page: Int) async throws -> MangaPage
//    func getMangas(customQuery query: DTOCustomSearch, page: Int) -> MangaPage  //TODO:REVIEW:
    func getBestMangas(page: Int) async throws -> MangaPage
    func getAuthors(by str: String) async throws -> [Author]
    
    // Filter criteria
    func getAuthors() async throws -> [Author]
    func getDemographics() async throws -> [String]
    func getGenres() async throws -> [String]
    func getThemes() async throws -> [String]
}

struct Network: DataInteractor {

    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func postJSON(request: URLRequest, status: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode != status {
            throw NetworkError.status(response.statusCode)
        }
    }

    // MARK: - DataInteractor methods
    func getMangaPage(_ page: Int) async throws -> MangaPage {
        try await getJSON(request: .get(url: .mangas(page: page)), type: DTOMangaPage.self).toModel
    }
    
    func getMangas(by filter: FilterBy, item: String, page: Int) async throws -> MangaPage {
        try await getJSON(request: .get(url: .mangas(by: filter, item: item, page: page)),
                          type: DTOMangaPage.self).toModel
    }
    
    func getMangas(beginsWith str: String) async throws -> [Manga] {
        try await getJSON(request: .get(url: .mangas(search: .begins, str: str)),
                          type: [DTOManga].self).map(\.toModel)
    }
    
    func getMangas(contains str: String, page: Int) async throws -> MangaPage {
        try await getJSON(request: .get(url: .mangas(search: .contains, str: str, page: page)),
                          type: DTOMangaPage.self).toModel
    }

    func getManga(id: String) async throws -> Manga {
        try await getJSON(request: .get(url: .mangas(search: .mangaId, str: id)),
                          type: DTOManga.self).toModel
    }

    //TODO:REVIEW:
//    func getMangas(customQuery query: DTOCustomSearch, page: Int) -> MangaPage {
//        let dtoMangaPage: DTOMangaPage = try await postJSON(request: .post(url: .mangas(search: .custom, page: page),
//                                          data: query))
//        return dtoMangaPage.toModel
//    }

    func getBestMangas(page: Int) async throws -> MangaPage {
        try await getJSON(request: .get(url: .bestMangas(page: page)),
                          type: DTOMangaPage.self).toModel
    }
    
    func getAuthors(by str: String) async throws -> [Author] {
        try await getJSON(request: .get(url: .mangas(search: .author, str: str)),
                          type: [DTOAuthor].self).map(\.toModel)
    }
    
    // Filter criteria
    func getAuthors() async throws -> [Author] {
        try await getJSON(request: .get(url: .authors), type: [DTOAuthor].self).map(\.toModel)
    }
    
    func getDemographics() async throws -> [String] {
        try await getJSON(request: .get(url: .demographics), type: [String].self)
    }
    
    func getGenres() async throws -> [String] {
        try await getJSON(request: .get(url: .genres), type: [String].self)
    }
    
    func getThemes() async throws -> [String] {
        try await getJSON(request: .get(url: .themes), type: [String].self)
    }
    
}
