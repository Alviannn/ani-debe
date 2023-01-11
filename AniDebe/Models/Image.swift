//
//  Image.swift
//  AniDebe
//
//  Created by prk on 1/10/23.
//

import Foundation

struct Image: Codable {
    
    let imageUrl: String
    let smallImageUrl: String
    let largeImageUrl: String
    
}

struct Images: Codable {
    
    let jpg: Image
    let webp: Image
    
}
