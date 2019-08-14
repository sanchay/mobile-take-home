//
//  CharacterImageFetcher.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation
import UIKit

typealias CharacterImageResult = (Result<UIImage, Error>) -> Void

struct CharacterImageFetcher {
    let networking: Networking
    let imageUrlString: String
    
    init(imageUrlString: String, networking: Networking) {
        self.imageUrlString = imageUrlString
        self.networking = networking
    }
    
    func fetch(response: @escaping CharacterImageResult) {
        networking.request(from: RickAndMortyApi.characterImage(imageUrlString)) { (data, error) in
            guard error == nil else {
                response(.failure(error!))
                return
            }
            guard let data = data else {
                response(.failure(ImageError.noImageData))
                return
            }
            guard let image = UIImage(data: data) else {
                response(.failure(ImageError.invalid))
                return
            }
            response(.success(image))
        }
    }
}
