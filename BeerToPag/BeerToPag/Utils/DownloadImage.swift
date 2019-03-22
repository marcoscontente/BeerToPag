//
//  UIImage+Extensions.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 18/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    public func downloadImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            completion(imageFromCache)
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard error == nil else  {
                debugPrint(error.debugDescription)
                completion(nil)
                return
            }
            guard let data = data else { return }

            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data)
                imageCache.setObject(image!, forKey: url as AnyObject)
                completion(image)
            })
        }).resume()
    }
}

