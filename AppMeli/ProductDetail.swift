//
//  ProductDetail.swift
//  AppMeli
//
//  Created by user on 20/06/24.
//

import Foundation


struct ProductDetail: Decodable {
    let id: String
    let title: String
    let price: Double
    let thumbnail: String?
    let condition: String?
    let pictures: [Picture]?
    let videoId: String?
    let warranty: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case thumbnail
        case condition 
        case pictures = "pictures"
        case videoId
        case warranty
    }
}


struct Picture: Decodable {
    let id: String
    let url: String
    let secureUrl: String?
    let size: String?
    let maxSize: String?
    let quality: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case secureUrl = "secure_url"
        case size
        case maxSize = "max_size"
        case quality
    }
}
