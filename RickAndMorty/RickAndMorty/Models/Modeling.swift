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
    func fetchEpisodes(completion: @escaping EpisodesResult)
    func fetchCharacters(characterIds: String, completion: @escaping CharactersResult)
    func fetchCharacterImage(urlString: String, completion: @escaping CharacterImageResult)
}

extension Modeling {
    func fetchEpisodes(completion: @escaping EpisodesResult) {
        let fetcher = EpisodesFetcher(networking: HttpNetworking())
        fetcher.fetch { episodesResult in
            completion(episodesResult)
        }
    }
    
    func fetchCharacters(characterIds: String, completion: @escaping CharactersResult) {
        let fetcher = CharactersFetcher(characterIds: characterIds, networking: HttpNetworking())
        fetcher.fetch { charactersResult in
            completion(charactersResult)
        }
    }
    
    func fetchCharacterImage(urlString: String, completion: @escaping CharacterImageResult) {
        let fetcher = CharacterImageFetcher(imageUrlString: urlString, networking: HttpNetworking())
        fetcher.fetch { characterImageResult in
            completion(characterImageResult)
        }
    }
}
