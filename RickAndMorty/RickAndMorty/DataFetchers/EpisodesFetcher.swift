//
//  EpisodesFetcher.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

typealias EpisodesResult = (Result<Episodes, Error>) -> Void

struct EpisodesFetcher: JSONDecodable {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func fetch(response: @escaping EpisodesResult) {
        networking.request(from: RickAndMortyApi.episodes) { (data, error) in
            guard error == nil else {
                response(.failure(error!))
                return
            }
            guard let decodedData = self.decode(type: Episodes.self, from: data) else {
                response(.failure(JSONError.invalid))
                return
            }
            response(.success(decodedData))
        }
    }
}
