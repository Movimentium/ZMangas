//
//  Network.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import Foundation

protocol DataInteractor {
    func getMangaPage() async throws -> MangaPage
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
    func getMangaPage() async throws -> MangaPage {
        try await getJSON(request: .get(url: .mangas(page: 1, per: 40)), type: DTOMangaPage.self).toModel
    }
}
