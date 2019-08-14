//
//  Episode.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
}

struct EpisodesInfo: Codable {
    let count: Int
    let pages: Int
    let next: String
    let prev: String
}

struct Episodes: Codable {
    let info: EpisodesInfo
    let results: [Episode]
}
