//
//  BeerListViewController.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 17/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {
    
    // Outlets
    @IBOutlet var beerTableView: UITableView!
    
    // Properties
    private let kRowHeight: CGFloat = 140
    private var isLoadingBeers: Bool = false
    private var lastPageCalled: Int = 0
    
    var beers = Beers() {
        didSet {
            DispatchQueue.main.async {
                self.beerTableView.reloadData()
            }
        }
    }

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        beerTableView.delegate = self
        beerTableView.dataSource = self
        self.view.startLoading()
        registerCell()
        verifyInternetConnection()
    }
    
    fileprivate func registerCell() {
        let nib = UINib.init(nibName: "BeerCell",
                             bundle: Bundle(for: type(of: self)))
        self.beerTableView.register(nib, forCellReuseIdentifier: "BeerCell")
    }
    
    fileprivate func verifyInternetConnection() {
        if (!Reachability.isConnectedToNetwork()) {
            self.view.stopLoading()
            self.showError(title: "No Internet",
                           message: "Please, check your internet connection.",
                           error: nil,
                           handler: { (UIAlertAction) in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                self.verifyInternetConnection()
                            }
            })
        } else {
            loadBeers()
        }
    }
    
    fileprivate func loadBeers(in page: Int? = 1) {
        self.isLoadingBeers = true
        ApiClient().fetchBeers(in: page!) { (response: Result<Beers>) in
            self.view.stopLoading()
            switch response {
            case .success(let beers):
                self.beers.append(contentsOf: beers)
                if let noDuplicates = self.beers.noDuplicates() {
                    self.beers = noDuplicates
                }
                self.lastPageCalled = page!
                DispatchQueue.main.async {
                    self.beerTableView.reloadData()
                }
                self.isLoadingBeers = false
                print(beers)
            case .failure(let error):
                print(error)
                self.showError(title: "Erro",
                          message: error.localizedDescription,
                          error: error)
            }
        }
    }
    
    fileprivate func loadMoreBeers() {
        let newBeerPage = self.lastPageCalled + 1
        print("newBeerPage: \(newBeerPage)")
        loadBeers(in: newBeerPage)
    }
}

// MARK: Table View Data Source
extension BeerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BeerCell = beerTableView.dequeueReusableCell(withIdentifier: "BeerCell",
                                                               for: indexPath) as! BeerCell
        cell.configCell(with: self.beers[indexPath.row])
        return cell
    }
}

// MARK: Table View Delegate
extension BeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = self.beers[indexPath.row]
        self.performSegue(withIdentifier: "showDetailsSegue", sender: beer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let beerDetailsViewController = segue.destination as? BeerDetailViewController {
            if let beer = sender as? Beer {
                beerDetailsViewController.beerDetail = beer
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard beers.count > Int() else { return }
        let lastLines = beers.count - 5
        if  (indexPath.item > lastLines && !self.isLoadingBeers) {
            self.loadMoreBeers()
            DispatchQueue.main.async {
                self.beerTableView.reloadData()
            }
        }
    }
}
