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
    
    
    func test_Network_BeersExpectedURL() {
        //Given
        let sut = ApiClient()
        let mockURLSession = MockURLSession()
        sut.session = mockURLSession
        
        //When
        let completion = { (beers: Beers?, error: Error?) in }
        sut.fetchBeers(onLoading: completion)
        
        //Then
        guard let url = mockURLSession.url else { XCTFail(); return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.scheme, "https")
        XCTAssertEqual(urlComponents?.host, "api.punkapi.com")
        XCTAssertEqual(urlComponents?.path, "/v2/beers")
    }
}

extension ApiClientTests {
    class MockURLSession: SessionProtocol {
        var url: URL?

        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
