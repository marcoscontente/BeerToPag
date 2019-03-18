//
//  BeerCellTests.swift
//  BeerToPagTests
//
//  Created by Marcos Vinicius Goncalves Contente on 18/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

@testable import BeerToPag
import XCTest

class BeerCellTest: XCTestCase {
    
    var tableView: UITableView!
    var cell: BeerCell!
    let dataSource = FakeDataSource()
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BeerListViewController") as! BeerListViewController
        _ = controller.view
        
        tableView = controller.tableView
        tableView.dataSource = dataSource
    
        cell = tableView?.dequeueReusableCell(withIdentifier: "BeerCell", for: IndexPath(row: 0, section: 0)) as? BeerCell
    }
    
    func test_HasNameLabel() {
        XCTAssertNotNil(cell.nameLabel)
    }
    
    func test_HasAbvLabel() {
        XCTAssertNotNil(cell.abvLabel)
    }
    
    func test_hasImagemView() {
        XCTAssertNotNil(cell.beerImageView)
    }
    
    func test_ConfigCell_SetsName() {
        cell.configCell(with: Beer(name: "Buzz", tagline: nil, description: nil, imageURL: "", abv: "", ibu: nil))
        XCTAssertEqual(cell.nameLabel.text, "Buzz")
    }
    
    func test_ConfigCell_SetsABV() {
        cell.configCell(with: Beer(name: "", tagline: nil, description: nil, imageURL: "", abv: "6.0", ibu: nil))
        XCTAssertEqual(cell.abvLabel.text, "6.0")
    }
}

extension BeerCellTest {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
