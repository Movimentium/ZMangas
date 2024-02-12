//
//  Utils.swift
//  ZMangas
//
//  Created by Miguel Gallego on 12/2/24.
//

import Foundation

struct U {
    private static let dateFormatterIn = ISO8601DateFormatter()    
    
    static func strDate(from strDate: String?) -> String {
        guard let str = strDate, let date = Self.dateFormatterIn.date(from: str) else {
            return ""
        }
        return date.formatted(date: .numeric, time: .omitted)
    }
}
