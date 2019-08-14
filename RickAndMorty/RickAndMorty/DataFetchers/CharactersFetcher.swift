//
//  CharactersFetcher.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-14.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

struct CharactersFetcher: JSONDecodable {
    let networking: Networking
    let characterIds: String
    
    init(characterIds: String, networking: Networking) {
        self.characterIds = characterIds
        self.networking = networking
    }
    
    func fetch(response: @escaping([Character]?) -> Void) {
        networking.request(from: RickAndMortyApi.characters(characterIds)) { (data, error) in
            if let error = error {
                // TODO: Add error handler
                print("Error caught: \(error.localizedDescription)")
                response(nil)
            }
            let characters = self.decode(type: [Character].self, from: data)
            response(characters)
        }
    }
}
