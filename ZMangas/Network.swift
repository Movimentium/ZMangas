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
    
    // Search criteria
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
    
    // Search criteria
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
    
    // Filter by
}
