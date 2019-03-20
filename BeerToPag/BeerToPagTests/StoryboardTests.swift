//
//  StoryboardTests.swift
//  BeerToPagTests
//
//  Created by Marcos Vinicius Goncalves Contente on 18/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

@testable import BeerToPag
import XCTest

class StoryboardTests: XCTestCase {

    func test_InitialViewController_IsBeerListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController =
            storyboard.instantiateInitialViewController()
                as! UINavigationController
        let rootViewController = navigationController.viewControllers[0]
        XCTAssertTrue(rootViewController is BeerListViewController)
    }
}
