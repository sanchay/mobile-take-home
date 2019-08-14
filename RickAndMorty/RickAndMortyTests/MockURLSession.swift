//
//  MockURLSession.swift
//  RickAndMortyTests
//
//  Created by Sanchay on 2019-08-14.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

enum HTTPResponseType {
    case success
    case limitReached
    case failure
}

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        print("Resume called")
    }
}

class MockURLSession: URLSessionProtocol {
    
    var expectedUrl: URL!
    var expectedData: Data?
    var expectedError: Error?
    var responseType: HTTPResponseType
    
    private let httpVersion = "HTTP/1.1"
    
    init() {
        responseType = .success
    }
    
    func runDataTask(with request: URLRequest, completionHandler: @escaping SessionResult) -> URLSessionDataTask {
        expectedUrl = request.url
        completionHandler(expectedData, response, expectedError)
        return MockURLSessionDataTask()
    }
}

extension MockURLSession {
    var response: HTTPURLResponse {
        switch responseType {
        case .success:
            return HTTPURLResponse(url: expectedUrl, statusCode: 200, httpVersion: httpVersion, headerFields: nil)!
        case .limitReached:
            return HTTPURLResponse(url: expectedUrl, statusCode: 429, httpVersion: httpVersion, headerFields: nil)!
        case .failure:
            return HTTPURLResponse(url: expectedUrl, statusCode: 400, httpVersion: httpVersion, headerFields: nil)!
        }
    }
}
