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
    let id: Int?
    let name: String?
    let tagline: String?
    let description: String?
    let imageURL: String?
    let abv: Double?
    let ibu: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, tagline, description
        case imageURL = "image_url"
        case abv, ibu
    }
}

// MARK: Collection Extension - Remove Duplicates

extension Collection {
    func noDuplicates() -> Beers? {
        let beers = (self as? Beers ?? [])
        var result = Beers()
        for beer in beers {
            let hasDuplicates = result.filter({ $0.id == beer.id }).count > Int()
            if !hasDuplicates {
                result.append(beer)
            }
        }
        return result
    }
}
