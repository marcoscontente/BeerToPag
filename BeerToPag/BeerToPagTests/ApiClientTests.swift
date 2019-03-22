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
    
    func test_ApiClient_WhenSuccessful_ReturnsBeer() {
        //Given
        let jsonData: [String: Any] = ["id" : 60,
                                       name : "Buzz",
                                       "tagline" : "A Real Bitter Experience.",
                                       "description" : "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
                                       "image_url" : "https://images.punkapi.com/v2/keg.png",
                                       "abv" : "4.5",
                                       "ibu" : "60"]
            
//            .data(using: .utf8)
        
//        let jsonData = TestBeer.beer()
        mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        //When
        let beerExpectation = expectation(description: "Beers")
        var catchedBeers: Beers = []
        sut.fetchBeers(page: 1) { (response: Result<Beers>) in
            switch response {
            case .success(let beers):
                catchedBeers = beers
                beerExpectation.fulfill()
            case .failure(let error):
                debugPrint(response)
                XCTFail(error.localizedDescription)
            }
        }
        
        //Then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertEqual(catchedBeers.first?.id, 1)
            XCTAssertEqual(catchedBeers.first?.name, "Buzz")
            XCTAssertEqual(catchedBeers.first?.tagline, "A Real Bitter Experience.")
            XCTAssertEqual(catchedBeers.first?.description, "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.")
            XCTAssertEqual(catchedBeers.first?.imageURL, "https://images.punkapi.com/v2/keg.png")
            XCTAssertEqual(catchedBeers.first?.abv, 4.5)
            XCTAssertEqual(catchedBeers.first?.ibu, 60)
        }
    }
    
    func test_ApiClient_WhenJsonIsInvalid_ReturnsError() {
        //Given
        mockURLSession = MockURLSession(data: Data(), urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        //When
        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
//        sut.fetchBeers(page: 1) { (Result.success) in
//            <#code#>
//        }
//        sut.fetchBeers { (response, error) in
//            catchedError = error
//            errorExpectation.fulfill()
//        }
        
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
        
//        sut.fetchBeers { (response) in
//            switch response {
//            case .success(_):
//                XCTFail()
//            case .failure (let error):
//                catchedError = error
//                errorExpectation.fulfill()
//            }
//        }

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
//        sut.fetchBeers { (response, error) in
//            catchedError = error
//            errorExpectation.fulfill()
//        }
        
        //Then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
    }
}

extension ApiClientTests {
    class MockURLSession: SessionProtocol {
        var url: URLRequest?
        private let dataTask: MockDataTask
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockDataTask(data: data, urlResponse: urlResponse, error: error)
        }
        
        func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
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

struct TestBeer {
    static let beer = Beer(id: 1, name: "Buzz", tagline: "A Real Bitter Experience.", description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.", imageURL: "https://images.punkapi.com/v2/keg.png", abv: 4.5, ibu: 60)
}
