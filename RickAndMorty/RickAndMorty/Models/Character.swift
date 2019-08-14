//
//  Character.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let image: String
    let created: String
}

extension Character: Comparable {
    static func < (lhs: Character, rhs: Character) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        guard let lhsDate = dateFormatter.date(from: lhs.created),
            let rhsDate = dateFormatter.date(from: rhs.created) else { return false }
        return lhsDate < rhsDate
    }
}
