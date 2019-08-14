//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import XCTest
@testable import RickAndMorty

private let jsonString = "{\"id\": 1, \"name\": \"sample\"}"
private let jsonData = jsonString.data(using: .utf8)

private struct MockModel: Codable {
    
    var id: Int
    var name: String
}

private struct ModelFetcher: JSONDecodable {
    
    func fetchObject() -> MockModel? {
        return self.decode(type: MockModel.self, from: jsonData)
    }
}

private struct MockEpisodeDecoder: JSONDecodable {
    
    func fetchObject(data: Data?) -> Episode? {
        return self.decode(type: Episode.self, from: data)
    }
}

private enum MockEndpoint: Endpoint {
    case mockUrl
    
    var path: String {
        return "http://mockurl"
    }
}

class RickAndMortyTests: XCTestCase {
    
    fileprivate var modelFetcher: ModelFetcher?
    fileprivate var mockEpisodeDecoder:MockEpisodeDecoder?

    override func setUp() {
        modelFetcher = ModelFetcher()
        mockEpisodeDecoder = MockEpisodeDecoder()
    }

    override func tearDown() {
        modelFetcher = nil
        mockEpisodeDecoder = nil
    }

    func testJSONDecodable() {
        let object = modelFetcher?.fetchObject()
        XCTAssertNotNil(object)
        XCTAssert((object as Any) is MockModel)
        XCTAssert(object?.id == 1)
        XCTAssert(object?.name == "sample")
    }
    
    func testDecodableEpisode() {
        let jsonString = "{\"id\": 1, \"name\": \"Episode #4\", \"air_date\":\"2017-11-04T18:50:21.651Z\"}"
        var jsonData = jsonString.data(using: .utf8)
        var object = mockEpisodeDecoder?.fetchObject(data: jsonData)
        XCTAssert(object == nil)
        
        let jsonString2 = "{\"id\": 1, \"name\": \"Episode #4\", \"air_date\":\"2017-11-04T18:50:21.651Z\", \"episode\":\"S01E01\", \"characters\":[]}"
        jsonData = jsonString2.data(using: .utf8)
        object = mockEpisodeDecoder?.fetchObject(data: jsonData)
        XCTAssertNotNil(object)
        XCTAssert((object as Any) is Episode)
        XCTAssert(object?.id == 1)
        XCTAssert(object?.name == "Episode #4")
        XCTAssert(object?.air_date == "2017-11-04T18:50:21.651Z")
        XCTAssert(object?.characters.count == 0)
    }
    
    func testMockSession() {
        guard let url = URL(string: MockEndpoint.mockUrl.path) else {
            fatalError("Invalid URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let mockSession = MockURLSession()
        mockSession.expectedData = jsonData
        mockSession.responseType = .success
        var task = mockSession.runDataTask(with: urlRequest) { (data, response, error) in
            XCTAssert((response as! HTTPURLResponse).statusCode == 200)
            XCTAssert((response as! HTTPURLResponse).url == url)
            XCTAssert(mockSession.expectedData == data)
        }
        task.resume()
        
        mockSession.responseType = .failure
        task = mockSession.runDataTask(with: urlRequest) { (data, response, error) in
            XCTAssert((response as! HTTPURLResponse).statusCode == 400)
            XCTAssert((response as! HTTPURLResponse).url == url)
            XCTAssert(mockSession.expectedData == data)
        }
        task.resume()
    }
    
    func testHttpNetworking() {
        let mockSession = MockURLSession()
        mockSession.expectedData = jsonData
        let httpNetworking = HttpNetworking(session: mockSession)
        httpNetworking.request(from: MockEndpoint.mockUrl) { (data, error) in
            XCTAssert(mockSession.expectedData == data)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
