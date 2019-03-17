//
//  ApiClientTests.swift
//  BeerToPagTests
//
//  Created by Marcos Vinicius Goncalves Contente on 17/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

@testable import BeerToPag
import XCTest

class ApiClientTests: XCTestCase {
    
    var sut: ApiClient!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        sut = ApiClient()
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
    }
    
    override func tearDown() {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
    }
    
    func test_ApiClient_ExpectedURL() {
        //Given
        sut.session = mockURLSession
        
        //When
        let completion = { (beers: [Beer]?, error: Error?) in }
        sut.fetchBeers(onComplete: completion)
        
        //Then
        guard let url = mockURLSession.url else { XCTFail(); return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.scheme, "https")
        XCTAssertEqual(urlComponents?.host, "api.punkapi.com")
        XCTAssertEqual(urlComponents?.path, "/v2/beers")
    }
    
    func test_ApiClient_WhenSuccessful_ReturnsBeer() {
        //Given
        let jsonData = "{\"name\" : \"Buzz\", \"tagline\" : \"A Real Bitter Experience.\", \"description\" : \"A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.\", \"image_url\" : \"https://images.punkapi.com/v2/keg.png\", \"abv\" : \"4.5\", \"ibu\" : \"60\"}".data(using: .utf8)
        mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        //When
        let beerExpectation = expectation(description: "Beers")
        var catchedBeers: [Beer]? = []
        sut.fetchBeers { response, error in
            catchedBeers = response
            beerExpectation.fulfill()
        }
        
        //Then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertEqual(catchedBeers?.first?.name, "Buzz")
            XCTAssertEqual(catchedBeers?.first?.tagline, "A Real Bitter Experience.")
            XCTAssertEqual(catchedBeers?.first?.description, "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.")
            XCTAssertEqual(catchedBeers?.first?.imageURL, "https://images.punkapi.com/v2/keg.png")
            XCTAssertEqual(catchedBeers?.first?.abv, "4.5")
            XCTAssertEqual(catchedBeers?.first?.ibu, "60")
        }
    }
    
    func test_ApiClient_WhenJsonIsInvalid_ReturnsError() {
        //Given
        mockURLSession = MockURLSession(data: Data(), urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        //When
        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
        sut.fetchBeers { (response, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        //Then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
    }
    
    func test_ApiClient_WhenDataIsNil_ReturnsError() {
        //Given
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        //When
        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
        sut.fetchBeers { (response, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        //Then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
    }
    
    func test_ApiClient_WhenResponseHasError_ReturnsError() {
        //Given
        let error = NSError(domain: "SomeError", code: 1234, userInfo: nil)
        let jsonData = "{\"name\" : \"Buzz\", \"tagline\" : \"A Real Bitter Experience.\", \"description\" : \"A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.\", \"image_url\" : \"https://images.punkapi.com/v2/keg.png\", \"abv\" : \"4.5\", \"ibu\" : \"60\"}".data(using: .utf8)
        mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: error)
        sut.session = mockURLSession
        
        //When
        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
        sut.fetchBeers { (response, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        //Then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
    }
}

extension ApiClientTests {
    class MockURLSession: SessionProtocol {
        var url: URL?
        private let dataTask: MockDataTask
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockDataTask(data: data, urlResponse: urlResponse, error: error)
        }

        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            dataTask.completionHandler = completionHandler
            return dataTask
        }
    }
    
    class MockDataTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.data, self.urlResponse, self.responseError)
            }
        }
    }
}
