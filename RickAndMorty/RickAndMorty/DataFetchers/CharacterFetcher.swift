//
//  CharacterFetcher.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

struct CharacterFetcher: JSONDecodable {
    let networking: Networking
    let characterId: Int
    
    init(characterId: Int, networking: Networking) {
        self.characterId = characterId
        self.networking = networking
    }
    
    func fetch(response: @escaping(Character?) -> Void) {
        networking.request(from: RickAndMortyApi.character(characterId)) { (data, error) in
            if let error = error {
                // TODO: Add error handler
                print("Error caught: \(error.localizedDescription)")
                response(nil)
            }
            
            response(self.decode(type: Character.self, from: data))
        }
    }
}
