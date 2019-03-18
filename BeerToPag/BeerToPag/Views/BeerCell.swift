//
//  BeerCell.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 17/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

class BeerCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var abvLabel: UILabel!
    @IBOutlet var beerImageView: UIImageView!
    
    func configCell(with beer: Beer) {
        nameLabel.text = beer.name
        abvLabel.text = beer.abv
        beerImageView.downloadImage(with: beer.imageURL)
    }
}
