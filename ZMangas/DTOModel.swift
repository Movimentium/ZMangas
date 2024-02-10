//
//  DTOModel.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import Foundation

struct DTOMangaPage: Codable {
    let items: [DTOManga]
    let metadata: DTOMetaData
}

struct DTOMetaData: Codable {
    let total: Int
    let page: Int
    let per: Int
}

struct DTOManga: Codable {
    let id: Int
    let title: String
    let titleJapanese: String?
    let titleEnglish: String?
    let score: Float
    
    let startDate: String?
    let endDate: String?
    let status: String
    let volumes: Int?
    let chapters: Int?

    let sypnosis: String?
    let background: String?
    let mainPicture: String?
//    let mainPicture: URL?
    
    let url: String?

    let authors: [DTOAuthor]
    let themes: [DTOTheme]
    let demographics: [DTODemographic]
    let genres: [DTOGenre]
}

struct DTOAuthor: Codable {
    let id: UUID
    let firstName: String
    let lastName: String
    let role: String
}

struct DTOTheme: Codable {
    let id: UUID
    let theme: String
}

struct DTODemographic: Codable {
    let id: UUID
    let demographic: String
}

struct DTOGenre: Codable {
    let id: UUID
    let genre: String
}

// MARK: - toModel
extension DTOMangaPage {
    var toModel: MangaPage {
        MangaPage(items: items.map(\.toModel), metadata: metadata.toModel)
    }
}

extension DTOMetaData {
    var toModel: MetaData {
        MetaData(total: total, page: page, per: per)
    }
}

extension DTOManga {
    var toModel: Manga {
        Manga(id: id,
              title: title,
              titleJapanese: titleJapanese,
              titleEnglish: title,
              score: score,
              startDate: startDate,
              endDate: endDate,
              status: status,
              volumes: volumes,
              chapters: chapters,
              sypnosis: sypnosis,
              background: background,
              coverURL: URL(string: mainPicture?.replacingOccurrences(of: "\"", with: "") ?? ""),
              url: URL(string: url?.replacingOccurrences(of: "\"", with: "") ?? ""),
              authors: authors.map(\.toModel),
              themes: themes.map(\.toModel),
              demographics: demographics.map(\.toModel),
              genres: genres.map(\.toModel))
    }
}

extension DTOAuthor {
    var toModel: Author {
        Author(id: id, firstName: firstName, lastName: lastName, role: role)
    }
}

extension DTOTheme {
    var toModel: Theme {
        Theme(id: id, theme: theme)
    }
}

extension DTODemographic {
    var toModel: Demographic {
        Demographic(id: id, demographic: demographic)
    }
}

extension DTOGenre {
    var toModel: Genre {
        Genre(id: id, genre: genre)
    }
}
