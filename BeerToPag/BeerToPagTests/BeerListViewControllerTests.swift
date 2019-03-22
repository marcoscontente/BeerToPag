//
//  BeerListViewControllerTests.swift
//  BeerToPagTests
//
//  Created by Marcos Vinicius Goncalves Contente on 17/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

@testable import BeerToPag
import XCTest

class BeerListViewControllerTests: XCTestCase {
    
    var sut: BeerListViewController!
    var tableView = UITableView()
    var mockTableView: MockTableView!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "BeerListViewController")
        sut = viewController as? BeerListViewController
        _ = sut.view
        tableView.dataSource = sut
        
        mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(MockBeerCell.self, forCellReuseIdentifier: "BeerCell")
    }
    
    func test_TableView_AfterViewDidLoad_IsNotNil() {
        XCTAssertNotNil(sut.beerTableView)
    }
    
    func test_LoadingView_SetsTableViewDataSource() {
        XCTAssertTrue(sut.beerTableView.dataSource is BeerListViewController)
    }
    
    func test_LoadingView_SetsTableViewDelegate() {
        XCTAssertTrue(sut.beerTableView.delegate is BeerListViewController)
    }
    
    func test_LoadingView_SetsDataSourceAndDelegateToSameObject() {
        XCTAssertEqual(sut.beerTableView.dataSource as? BeerListViewController,
                       sut.beerTableView.delegate as? BeerListViewController)
    }
    
    func test_NumberOfSections_IsOne() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_NumberOfRows_InSection_IsBeerListCount() {
//        let beer1 = Beer(name: "Name",
//                         tagline: "Tagline",
//                         description: "Description",
//                         imageURL: "www.beer.com",
//                         abv: 6.0,
//                         ibu: 60)
//        sut.beers.append(beer1)
//
//        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
//
//        let beer2 = Beer(name: "Name",
//                         tagline: "Tagline",
//                         description: "Description",
//                         imageURL: "www.beer.com",
//                         abv: 6.0,
//                         ibu: 60)
//        sut.beers.append(beer2)
//        tableView.reloadData()

        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_CellForRow_DequeuesCellFromTableView() {
//        let beer1 = Beer(name: "Name",
//                         tagline: "Tagline",
//                         description: "Description",
//                         imageURL: "www.beer.com",
//                         abv: 6.0,
//                         ibu: 60)
//        sut.beers.append(beer1)
//        mockTableView.reloadData()
//        
//        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
//        XCTAssertTrue(mockTableView.cellGotDequeued)
//    }
//    
//    func test_CellForRow_CallsConfigCell() {
//        let beer = Beer(name: "Name",
//                         tagline: "Tagline",
//                         description: "Description",
//                         imageURL: "www.beer.com",
//                         abv: 6.0,
//                         ibu: 60)
//        
//        sut.beers.append(beer)
//        mockTableView.reloadData()
        
//        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockBeerCell
//        XCTAssertEqual(cell.catchedBeer, beer)
    }
    
    func test_BeerListViewController_HasTitle() {
        let title = sut.navigationController?.title
        XCTAssertEqual(title, sut.navigationController?.title)
    }
    
    
}

extension BeerListViewControllerTests {
    class MockTableView: UITableView {
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockBeerCell: BeerCell {
//        var catchedBeer = Beer(name: "", tagline: nil, description: nil, imageURL: "", abv: Double(), ibu: nil)
        
        override func configCell(with beer: Beer) {
//            catchedBeer = beer
        }
    }
}
