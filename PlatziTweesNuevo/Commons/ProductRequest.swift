//
//  ProductRequest.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 04-12-22.
//

import Foundation

struct ProductsRequest: Codable {
    let title: String
    let price: Int
    let productsRequestDescription: String
    let categoryID: Int
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case title, price
        case productsRequestDescription = "description"
        case categoryID = "categoryId"
        case images
    }
}
