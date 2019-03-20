//
//  UIImage+Extensions.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 18/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func downloadImage(with url: URL) {
        self.image = nil
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard error == nil else  {
                debugPrint(error.debugDescription)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}


