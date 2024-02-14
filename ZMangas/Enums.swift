//
//  Enums.swift
//  ZMangas
//
//  Created by Miguel Gallego on 8/2/24.
//

import Foundation

enum FilterBy: String, CaseIterable {
    case genre = "mangaByGenre"
    case theme = "mangaByTheme"
    case demographic = "mangaByDemographic"
    case author = "mangaByAuthor"
    
    var name: String {
        switch self {
        case .genre:  "Género"
        case .theme:  "Temática"
        case .demographic:  "Demografía"
        case .author:  "Autor"
        }
    }
}

enum SearchType: String {
    case begins = "mangasBeginsWith"
    case contains = "mangasContains"
    case author
    case mangaId = "manga"
    case custom
    
    static var forTitle: [SearchType] {
        [.begins, .contains]
    }
    
    var name: String {
        switch self {
        case .begins:  "Comienza por"
        case .contains:  "Contiene"
        case .author:  "Autor"
        case .mangaId:  "Id del manga"
        case .custom:  "Custom"
        }
    }
    
}
