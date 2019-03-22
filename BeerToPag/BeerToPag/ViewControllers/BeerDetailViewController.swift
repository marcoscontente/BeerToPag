//
//  BeerDetailViewController.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 18/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var taglineLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var abvLabel: UILabel!
    @IBOutlet var ibuLabel: UILabel!
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    var beerDetail: Beer?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        setupView()
    }
    
    // MARK: - Layout methods
    fileprivate func setupView() {
        activityIndicator.style = .whiteLarge
        activityIndicator.startAnimating()
        guard let beer = beerDetail else {
            debugPrint("No beer")
            return
        }
        
        let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.titleFontSize,
                                                                             weight: .medium)]
        let attributedName = NSMutableAttributedString(string: beer.name ?? Constants.naText,
                                                       attributes: titleAttribute)
        nameLabel.attributedText = attributedName
        
        let subTitleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.subTextFontSize,
                                                                             weight: .medium)]
        let attributedTag = NSMutableAttributedString(string: beer.tagline ?? Constants.naText,
                                                       attributes: subTitleAttribute)
        taglineLabel.attributedText = attributedTag
        
        let textAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.textFontSize,
                                                                            weight: .medium)]
        let coloredBoldAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.textFontSize,
                                                                                    weight: .bold),
                                     NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.862745098, green: 0.631372549, blue: 0.1411764706, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedAbv = NSMutableAttributedString(string: String(format: "%.1f", beer.abv ?? 0),
                                                      attributes: textAttribute)
        attributedAbv.append(NSMutableAttributedString(string: Constants.percentText,
                                                       attributes: textAttribute))
        attributedAbv.append(NSMutableAttributedString(string: Constants.abvText,
                                                       attributes: coloredBoldAttributes))
        abvLabel.attributedText =  attributedAbv
        
        let attributedIbu = NSMutableAttributedString(string: String(format: "%.f", beer.ibu ?? 0 ),
                                                      attributes: textAttribute)
        attributedIbu.append(NSMutableAttributedString(string: Constants.ibuText,
                                                       attributes: coloredBoldAttributes))
        ibuLabel.attributedText = attributedIbu
        
        let attributedDescription = NSMutableAttributedString(string: beer.description ?? Constants.naText,
                                                      attributes: subTitleAttribute)
        descriptionLabel.attributedText = attributedDescription
        
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
