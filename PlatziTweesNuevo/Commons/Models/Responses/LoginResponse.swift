//
//  LoginResponse.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 02-12-22.
//

import Foundation

struct LoginResponse: Codable{
    let user: User
    let token: String
}
