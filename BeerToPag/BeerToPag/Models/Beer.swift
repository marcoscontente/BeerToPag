//
//  Beers.swift
//  BeerToPag
//
//  Created by Marcos Vinicius Goncalves Contente on 17/03/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

typealias Beers = [Beer]

struct Beer: Codable, Equatable {
    let name: String
    let tagline: String?
    let description: String?
    let imageURL: String
    let abv: String
    let ibu: String?
    
    enum CodingKeys: String, CodingKey {
        case name, tagline, description
        case imageURL = "image_url"
        case abv, ibu
    }
}
