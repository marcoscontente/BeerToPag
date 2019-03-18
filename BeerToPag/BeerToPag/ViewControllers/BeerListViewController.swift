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
        registerCells()
        loadData()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "BeerCell", bundle: nil),
                           forCellReuseIdentifier: "BeerCell")
    }
    
    private func loadData() {
        ApiClient().fetchBeers { (responseBeers, error) in
            for beer in responseBeers! {
                self.beers.append(beer)
            }
        }
    }
}

// MARK: Table View Data Source
extension BeerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell", for: indexPath) as! BeerCell
        cell.configCell(with: beers[indexPath.row])
        return cell
    }
}

// MARK: Table View Delegate
extension BeerListViewController: UITableViewDelegate {
    
}
