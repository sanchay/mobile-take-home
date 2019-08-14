//
//  EpisodesFetcher.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

struct EpisodesFetcher: JSONDecodable {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func fetch(response: @escaping (Episodes?) -> Void ) {
        networking.request(from: RickAndMortyApi.episodes) { (data, error) in
            if let error = error {
                // TODO: Add error handler
                print("Error caught: \(error.localizedDescription)")
                response(nil)
            }
            
            response(self.decode(type: Episodes.self, from: data))
        }
    }
}
