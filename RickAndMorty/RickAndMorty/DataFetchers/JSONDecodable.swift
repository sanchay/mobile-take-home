//
//  Decodable.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

protocol JSONDecodable {}

extension JSONDecodable {
    func decode<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        guard let decodedData = try? decoder.decode(type, from: data) else { return nil }
        return decodedData
    }
}
