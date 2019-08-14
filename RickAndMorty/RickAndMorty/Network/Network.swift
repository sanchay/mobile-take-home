//
//  Network.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    typealias SessionResult = (Data?, URLResponse?, Error?) -> Void
    
    func runDataTask(with request: URLRequest, completionHandler: @escaping SessionResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    func runDataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.SessionResult) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}

protocol Networking {
    typealias CompletionHandler = (Data?, Swift.Error?) -> Void

    func request(from endpoint: Endpoint, completion: @escaping CompletionHandler)
}

struct HttpNetworking: Networking {
    private let session: URLSessionProtocol
    
    init() {
        self.session = URLSession.shared
    }
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func request(from: Endpoint, completion: @escaping CompletionHandler) {
        guard let url = URL(string: from.path) else { return }
        let request = URLRequest(url: url)
        DispatchQueue.global(qos: .background).async {
            let task = self.session.runDataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            }
            task.resume()
        }
    }
}
