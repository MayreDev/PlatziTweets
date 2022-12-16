//
//  RegisterRequest.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 02-12-22.
//

import Foundation

struct RegisterRequest: Codable{
    let name: String
    let email: String
    let password: String
    let avatar: String
}
