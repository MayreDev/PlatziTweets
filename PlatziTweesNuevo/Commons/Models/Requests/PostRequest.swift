//
//  PostRequest.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 02-12-22.
//

import Foundation

struct PostRequest: Codable{
    let text: String
    let imageUrl: String?
    let videoUrl: String?
    let location: PostRequestLocation?
}
