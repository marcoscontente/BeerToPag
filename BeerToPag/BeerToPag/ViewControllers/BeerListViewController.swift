//
//  BeerListViewController.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 17/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {
    
    // Properties
    var beers: Beers = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Outlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: Table View Data Source
extension BeerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath)
        return cell
    }
}

// MARK: Table View Delegate
extension BeerListViewController: UITableViewDelegate {
    
}
