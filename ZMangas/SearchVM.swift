//
//  SearchVM.swift
//  ZMangas
//
//  Created by Miguel Gallego on 8/2/24.
//

import Foundation

final class SearchVM: ObservableObject {
    let interactor: DataInteractor
    
    @Published var filterBy = FilterBy.genre
    var itemToFilter = ""
    
    var demographics: [String] = []
    var genres: [String] = []
    var themes: [String] = []
    var authors: [Author] = []

    @Published var showFilter = false
    @Published var searchAuthorInList = ""
    @Published var selectedItem: String? { didSet {
        itemToFilter = selectedItem ?? "" }
    }
    @Published var selectedAuthorID: UUID? { didSet {
        itemToFilter = selectedAuthorID?.uuidString ?? "" }
    }
    
    var arrayToShow: [String] {
        switch filterBy {
        case .genre:  genres
        case .theme:  themes
        case .demographic:  demographics
        case .author:  [] // No aplicable
        }
    }
    
    var authorsFiltered: [Author] {
        if searchAuthorInList.isEmpty {
            return authors
        } else {
            return authors.filter {
                $0.fullName.range(of: searchAuthorInList, options: [.caseInsensitive, .diacriticInsensitive]) != nil
            }
        }
    }

    init(interactor: DataInteractor = Network()) {
        self.interactor = interactor
        Task {
            await getSearchCriteria()
        }
    }
    
    func getSearchCriteria() async {
        do {
            async let authors = interactor.getAuthors()
            async let demographics = interactor.getDemographics()
            async let genres = interactor.getGenres()
            async let themes = interactor.getThemes()
            let criteria = try await (authors, demographics, genres, themes)
            await MainActor.run {
                self.authors = criteria.0.sorted { $0.fullName < $1.fullName}
                self.demographics = criteria.1.sorted {$0 < $1 }
                self.genres = criteria.2.sorted {$0 < $1 }
                self.themes = criteria.3.sorted {$0 < $1 }
            }
        } catch {
            print(error)
        }
    }

    var isValidSelection: Bool {
        if itemToFilter.isEmpty {
            //TODO: mostrar alerta
            return false
        } else {
            showFilter = false 
            return true
        }
    }
}
