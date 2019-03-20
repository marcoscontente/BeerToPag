//
//  BeerDetailViewControllerTests.swift
//  BeerToPagTests
//
//  Created by Marcos Vinicius Goncalves Contente on 18/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

@testable import BeerToPag
import XCTest

class BeerDetailViewControllerTests: XCTestCase {
    
    var sut: BeerDetailViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "BeerDetailViewController") as? BeerDetailViewController
        _ = sut.view
    }
    
    func test_HasNameLabel() {
        XCTAssertNotNil(sut.nameLabel)
    }
    
    func test_HasTaglineLabel() {
        XCTAssertNotNil(sut.taglineLabel)
    }
    
    func test_HasABVLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
    }
    
    func test_HasIBULabel() {
        XCTAssertNotNil(sut.ibuLabel)
    }
    
    func test_HasDescriptionLabel() {
        XCTAssertNotNil(sut.abvLabel)
    }
    
    func test_HasImageView() {
        XCTAssertNotNil(sut.beerImageView)
    }
    
    
    
}
