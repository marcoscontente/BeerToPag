//
//  UIView_Alert+Extensions.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 19/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(title: String, message: String, error: Error) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print(">> Error:", error.localizedDescription)
    }
}
