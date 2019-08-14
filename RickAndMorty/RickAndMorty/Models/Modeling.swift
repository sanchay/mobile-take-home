//
//  Modeling.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-14.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation
import UIKit

protocol Modeling {
    func fetchEpisodes(completion: @escaping (Episodes) -> Void)
    func fetchCharacter(id: Int, completion: @escaping (Character) -> Void)
    func fetchCharacterImage(urlString: String, completion: @escaping(UIImage?) -> Void)
}

extension Modeling {
    func fetchEpisodes(completion: @escaping (Episodes) -> Void) {
        let fetcher = EpisodesFetcher(networking: HttpNetworking())
        fetcher.fetch { episodes in
            if let episodes = episodes {
                completion(episodes)
            }
        }
    }
    
    func fetchCharacter(id: Int, completion: @escaping (Character) -> Void) {
        let fetcher = CharacterFetcher(characterId: id, networking: HttpNetworking())
        fetcher.fetch { (character) in
            if let character = character {
                completion(character)
            }
        }
    }
    
    func fetchCharacterImage(urlString: String, completion: @escaping(UIImage?) -> Void) {
        let fetcher = CharacterImageFetcher(imageUrlString: urlString, networking: HttpNetworking())
        fetcher.fetch { (image) in
            completion(image)
        }
    }
}
