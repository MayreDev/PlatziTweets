//
//  EndPoints.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 02-12-22.
//

import Foundation

struct Endpoints {
    static let domain = "https://api.escuelajs.co/api/v1"
    static let login = Endpoints.domain + "/users"
    static let register = Endpoints.domain + "/users/"
    static let getPosts = Endpoints.domain + "/products"
    static let posts = Endpoints.domain + "/products"
    static let delete = Endpoints.domain + "/products/"

}
