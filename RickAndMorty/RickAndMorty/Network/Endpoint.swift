//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
}

enum RickAndMortyApi {
    case episodes
    case character(String)
    case characterImage(String)
}

extension RickAndMortyApi: Endpoint {
    var path: String {
        switch self {
        case .episodes:
            return "https://rickandmortyapi.com/api/episode"
        case .character(let characterUrlString):
            return characterUrlString
        case .characterImage(let imageUrlString):
            return imageUrlString
        }
    }
}
