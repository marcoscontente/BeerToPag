//
//  ApiClient.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 17/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class ApiClient {
    
    // Properties
    lazy var session: SessionProtocol = URLSession.shared
    
    func fetchBeers<T: Codable>(in page: Int, onComplete: @escaping (Result<T>) -> Void) {
        let url = URL(string: "https://api.punkapi.com/v2/beers")
        
        let parameters: [String: String] = ["page": "\(page)"]

        var components = URLComponents(url: url!, resolvingAgainstBaseURL: false)!
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        let request = URLRequest(url: components.url!)
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                onComplete(.failure(error))
            }

            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                onComplete(.success(response))
            } catch {
                onComplete(.failure(error))
            }
            }.resume()
    }
}
