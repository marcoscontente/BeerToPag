//
//  ApiClient.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 17/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

class ApiClient {
    // Properties
    lazy var session: SessionProtocol = URLSession.shared
    
    func fetchBeers(onLoading: @escaping (_ beers: Beers?, _ error: Error?) -> Void) {
        guard let url  = URL(string: "https://api.punkapi.com/v2/beers") else { fatalError() }
        
        session.dataTask(with: url) { data, response, error in
            
        }
    }
}
