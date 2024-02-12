//
//  Model.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import Foundation

struct MangaPage: Codable {
    let items: [Manga]
    let metadata: MetaData
}

struct MetaData: Codable {
    let total: Int
    let page: Int
    let per: Int
}

struct Manga: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let titleJapanese: String?
    let titleEnglish: String?
    let score: String
    
    let startDate: String?
    let endDate: String?
    let status: String
    let volumes: Int?
    let chapters: Int?
    
    let sypnosis: String?
    let background: String?
    let coverURL: URL?
    let url: URL?
    
    let authors: [Author]
    let themes: [Theme]
    let demographics: [Demographic]
    let genres: [Genre]
}

struct Author: Codable, Identifiable, Hashable {
    let id: UUID
    let firstName: String
    let lastName: String
    let role: String
}

struct Theme: Codable, Hashable {
    let id: UUID
    let theme: String
}

struct Demographic: Codable, Hashable  {
    let id: UUID
    let demographic: String
}

struct Genre: Codable, Hashable  {
    let id: UUID
    let genre: String
}


extension Manga {
    var authorsFullNames: String {
        authors.reduce("") { ($0.isEmpty ? $0 : "\($0), ") + $1.fullName}
    }
    
    var strGenres: String {
        genres.reduce("") { ($0.isEmpty ? $0 : "\($0), ") + $1.genre}
    }
    
    var strDemographics: String {
        demographics.reduce("") { ($0.isEmpty ? $0 : "\($0), ") + $1.demographic}
    }
    
    var strThemes: String {
        themes.reduce("") { ($0.isEmpty ? $0 : "\($0), ") + $1.theme}
    }
    
    var strVolumes: String {
        if let vols = volumes {
            return "\(vols)"
        } else {
            return "N/A"
        }
    }
    
    var strChapters: String {
        if let chapts = chapters {
            return "\(chapts)"
        } else {
            return "N/A"
        }
    }
    
    var strStartDate: String {
        U.strDate(from: startDate)
    }
    
    var strEndDate: String {
        U.strDate(from: endDate)
    }
    
}

extension Author {
    var fullName: String {
        if firstName.isEmpty {
           return lastName
        }
        return "\(firstName) \(lastName)"
    }
}

extension MetaData: CustomStringConvertible {
    var description: String {
        "per: \(per), page: \(page), total: \(total)"
    }
}
