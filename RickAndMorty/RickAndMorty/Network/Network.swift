//
//  Network.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

protocol Networking {
    typealias CompletionHandler = (Data?, Swift.Error?) -> Void

    func request(from endpoint: Endpoint, completion: @escaping CompletionHandler)
}

struct HttpNetworking: Networking {
    func request(from: Endpoint, completion: @escaping CompletionHandler) {
        guard let url = URL(string: from.path) else { return }
        let request = URLRequest(url: url)
        DispatchQueue.global(qos: .background).async {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            }
            task.resume()
        }
    }
}
