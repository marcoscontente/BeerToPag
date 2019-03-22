//
//  BeerCell.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 17/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

class BeerCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var abvLabel: UILabel!
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Config cell
    func configCell(with beer: Beer) {
        activityIndicator.style = .whiteLarge
        activityIndicator.startAnimating()
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.titleFontSize,
                                                                                    weight: .bold)]
        let coloredBoldAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.textFontSize,
                                                                                    weight: .bold),
                                     NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.862745098, green: 0.631372549, blue: 0.1411764706, alpha: 1)] as [NSAttributedString.Key : Any]
        let fontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.textFontSize,
                                                                            weight: .medium)]
        
        nameLabel.attributedText = NSMutableAttributedString(string: beer.name ?? Constants.naText,
                                                             attributes: titleAttributes)
        
        let attributedAbv = NSMutableAttributedString(string: String(format: "%.1f", beer.abv ?? 0),
                                                      attributes: fontAttribute)
        attributedAbv.append(NSMutableAttributedString(string: Constants.percentText,
                                                       attributes: fontAttribute))
        attributedAbv.append(NSMutableAttributedString(string: Constants.abvText,
                                                       attributes: coloredBoldAttributes))
        abvLabel.attributedText =  attributedAbv
        
        if let imageURL = beer.imageURL,
            let url = URL(string: imageURL) {
                beerImageView.downloadImage(with: url) { image in
                    DispatchQueue.main.async {
                        self.beerImageView.image = image
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.hidesWhenStopped = true
                    }
                }
        } else {
            DispatchQueue.main.async {
                self.beerImageView.image = UIImage(named: "beerPlaceholder")
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidesWhenStopped = true
            }
        }
    }
}

