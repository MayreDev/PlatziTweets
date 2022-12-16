//
//  ProductsModel.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 02-12-22.
//

import Foundation

struct ProductsModel: Codable {
    let id: Int
    let title: String
    let price: Int
    let productsModelDescription: String
    let category: Category
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case productsModelDescription = "description"
        case category, images
    }
}

// MARK: - Category
struct Category: Codable {
    var id: Int = 011
    var name: String = "fff"
    var image: String = "ggg"
}
