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
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "BeerListViewController")
        sut = viewController as? BeerListViewController
        _ = sut.view
        tableView.dataSource = sut
    }
    
    func test_TableView_AfterViewDidLoad_IsNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_SetsTableViewDataSource() {
        XCTAssertTrue(sut.tableView.dataSource is BeerListViewController)
    }
    
    func test_LoadingView_SetsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is BeerListViewController)
    }
    
    func test_LoadingView_SetsDataSourceAndDelegateToSameObject() {
        XCTAssertEqual(sut.tableView.dataSource as? BeerListViewController,
                       sut.tableView.delegate as? BeerListViewController)
    }
    
    func test_NumberOfSections_IsOne() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_NumberOfRows_InSection_IsBeerListCount() {
        let beer1 = Beer(name: "Name",
                         tagline: "Tagline",
                         description: "Description",
                         imageURL: "www.beer.com",
                         abv: "6.0",
                         ibu: "60")
        sut.beers.append(beer1)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        let beer2 = Beer(name: "Name",
                         tagline: "Tagline",
                         description: "Description",
                         imageURL: "www.beer.com",
                         abv: "6.0",
                         ibu: "60")
        sut.beers.append(beer2)
        tableView.reloadData()

        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_CellForRow_DequeuesCellFromTableView() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(BeerListCell.self,
                               forCellReuseIdentifier: "BeerListCell")
        
        let beer1 = Beer(name: "Name",
                         tagline: "Tagline",
                         description: "Description",
                         imageURL: "www.beer.com",
                         abv: "6.0",
                         ibu: "60")
        sut.beers.append(beer1)
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellGotDequeued)
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
}
