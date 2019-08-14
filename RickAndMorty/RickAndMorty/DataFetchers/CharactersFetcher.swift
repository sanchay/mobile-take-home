//
//  CharactersFetcher.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-14.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

typealias CharactersResult = (Result<[Character], Error>) -> Void

struct CharactersFetcher: JSONDecodable {
    let networking: Networking
    let characterIds: String
    
    init(characterIds: String, networking: Networking) {
        self.characterIds = characterIds
        self.networking = networking
    }
    
    func fetch(response: @escaping CharactersResult) {
        networking.request(from: RickAndMortyApi.characters(characterIds)) { (data, error) in
            guard error == nil else {
                response(.failure(error!))
                return
            }
            guard let decodedData = self.decode(type: [Character].self, from: data) else {
                response(.failure(JSONError.invalid))
                return
            }
            response(.success(decodedData))
        }
    }
}
