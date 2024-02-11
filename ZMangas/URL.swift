//
//  URL.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import Foundation

let api = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/")!

extension URL {
    static let per = 50
    static let mangas = api.appending(path: "list/mangas")
    static let bestMangas = api.appending(path: "list/bestMangas")
    static let authors = api.appending(path: "list/authors")
    static let demographics = api.appending(path: "list/demographics")
    static let genres = api.appending(path: "list/genres")
    static let themes = api.appending(path: "list/themes")

    static func mangas(page: Int) -> URL {
        Self.mangas.appendingPagingIfNeeded(page: page)
    }
        
    // MARK: - MangaBy...
    static func mangas(by: FilterBy, item: String, page: Int) -> URL {
        api.appending(path: "list/\(by.rawValue)/\(item)").appendingPagingIfNeeded(page: page)
    }
    
    // MARK: - Searches
    enum Search: String {
        case begins = "mangasBeginsWith"
        case contains = "mangasContains"
        case author
        case mangaId = "manga"
        case custom
    }
    
    static func mangas(search: Search, str: String = "", page: Int? = nil) -> URL {
        return switch search {
        case .custom:
            api.appending(path: "search/manga").appendingPagingIfNeeded(page: page)
        default:
            api.appending(path: "search/\(search.rawValue)/\(str)").appendingPagingIfNeeded(page: page)
        }
    }
    
    private func appendingPagingIfNeeded(page: Int?) -> URL {
        if let page {
            let queryItems = [URLQueryItem(name: "page", value: "\(page)"),
                              URLQueryItem(name: "per", value: "\(Self.per)")]
            return self.appending(queryItems: queryItems)
        } else {
            return self
        }
    }
}
