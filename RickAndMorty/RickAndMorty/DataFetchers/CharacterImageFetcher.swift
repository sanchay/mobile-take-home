//
//  CharacterImageFetcher.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation
import UIKit

struct CharacterImageFetcher {
    let networking: Networking
    let imageUrlString: String
    
    init(imageUrlString: String, networking: Networking) {
        self.imageUrlString = imageUrlString
        self.networking = networking
    }
    
    func fetch(response: @escaping(UIImage?) -> Void) {
        networking.request(from: RickAndMortyApi.characterImage(imageUrlString)) { (data, error) in
            if let error = error {
                // TODO: Add error handler
                print("Error caught: \(error.localizedDescription)")
                response(nil)
            }
            
            guard let data = data else {
                response(nil)
                return
            }
            response(UIImage(data: data))
        }
    }
}
