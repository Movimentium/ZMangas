//
//  DBModel.swift
//  ZMangas
//
//  Created by Miguel Gallego on 12/2/24.
//

import Foundation
import SwiftData

@Model
final class DBManga: CustomStringConvertible {
    @Attribute(.unique) let id: Int
    var volumesIHave: Int = 0
    var volumeIamReading: Int = 0
    var isCompleteCollection: Bool = false
    
    init(id: Int) {
        self.id = id
    }
    
    var description: String {
        "id: \(id), vols: \(volumesIHave), reading: \(volumeIamReading)"
    }
}

struct MyManga: Identifiable, Hashable {
    var id: Int {
        return dbManga.id
    }
    var manga: Manga
    var dbManga: DBManga
}
