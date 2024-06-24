//
//  Product.swift
//  AppMeli
//
//  Created by user on 20/06/24.
//

import Foundation


struct Product: Decodable {
    let id: String
    let title: String
    let price: Double
    let thumbnail: String
    let condition: String
    let availableQuantity: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case thumbnail
        case condition
        case availableQuantity = "available_quantity"
    }
}
