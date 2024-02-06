//
//  URL.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import Foundation

let api = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/")!

extension URL {
    static let mangas = api.appending(path: "list/mangas")
    static let bestMangas = api.appending(path: "list/bestMangas")
    static let authors = api.appending(path: "list/authors")
    static let genres = api.appending(path: "list/genres")
    static let themes = api.appending(path: "list/themes")

    static func mangas(page: Int? = nil, per: Int? = nil) -> URL {
        Self.mangas.appendingPagingIfNeeded(page: page, per: per)
    }
    
    // MARK: - MangaBy...
    enum By: String {
        case genre = "mangaByGenre"
        case theme = "mangaByTheme"
        case demographic = "mangaByDemographic"
        case author = "mangaByAuthor"
    }

    static func mangas(by: By, item: String, page: Int? = nil, per: Int? = nil) -> URL {
        api.appending(path: "list/\(by.rawValue)/\(item)").appendingPagingIfNeeded(page: page, per: per)
    }
    
    // MARK: - Searches
    enum Search: String {
        case begins = "mangasBeginsWith"
        case contains = "mangasContains"
        case author
        case mangaOrCustom = "manga"  // TODO:
    }
    
    static func mangas(search: Search, str: String, page: Int? = nil, per: Int? = nil) -> URL {
        api.appending(path: "search/\(search.rawValue)/\(str)").appendingPagingIfNeeded(page: page, per: per)
    }
    
    private func appendingPagingIfNeeded(page: Int?, per: Int?) -> URL {
        if let page, let per {
            let queryItems = [URLQueryItem(name: "page", value: "\(page)"),
                              URLQueryItem(name: "per", value: "\(per)")]
            return self.appending(queryItems: queryItems)
        } else {
            return self
        }
    }
}