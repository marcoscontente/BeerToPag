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
    
    func fetchBeers(onComplete: @escaping (_ beers: [Beer]?, _ error: Error?) -> Void) {
        guard let url  = URL(string: "https://api.punkapi.com/v2/beers") else { fatalError() }
        
        session.dataTask(with: url) { data, response, error in
            guard error == nil else  {
                onComplete(nil, error)
                return
            }
            guard let data = data else {
                onComplete(nil, NetworkError.DataEmptyError)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Beer.self, from: data)
                onComplete([response], nil)
            } catch {
                onComplete(nil, error)
            }
        }.resume()
    }
}
