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

struct Manga: Codable, Identifiable {
    let id: Int
    let title: String
    let titleJapanese: String
    let titleEnglish: String?
    let score: Float
    
    let startDate: String
    let endDate: String?
    let status: String
    let volumes: Int?
    let chapters: Int?

    let sypnosis: String
    let background: String?
    let mainPicture: URL?
    let url: URL?

    let authors: [Author]
    let themes: [Theme]
    let demographics: [Demographic]
    let genres: [Genre]
}

struct Author: Codable {
    let id: UUID
    let firstName: String
    let lastName: String
    let role: String
}

struct Theme: Codable {
    let id: UUID
    let theme: String
}

struct Demographic: Codable {
    let id: UUID
    let demographic: String
}

struct Genre: Codable {
    let id: UUID
    let genre: String
}
