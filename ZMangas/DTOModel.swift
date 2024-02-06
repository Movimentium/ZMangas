//
//  DTOModel.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import Foundation


struct DTOMetaData: Codable {
    let total: Int
    let page: Int
    let per: Int
}

struct DTOManga: Codable {
    let id: Int
    let title: String
    let titleJapanese: String
    let titleEnglish: String
    let score: Float
    
    let startDate: String
    let endDate: String
    let status: String
    let volumes: Int
    let chapters: Int

    let sypnosis: String
    let background: String
    let mainPicture: URL
    let url: URL

    let authors: [DTOAuthors]
    let themes: [DTOThemes]
    let demographics: [DTODemographics]
    let genres: [DTOGenres]
}

struct DTOAuthors: Codable {
    let id: UUID
    let firstName: String
    let lastName: String
    let role: String
}

struct DTOThemes: Codable {
    let id: UUID
    let theme: String
}

struct DTODemographics: Codable {
    let id: UUID
    let demographic: String
}

struct DTOGenres: Codable {
    let id: UUID
    let genre: String
}
