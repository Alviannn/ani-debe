//
//  Anime.swift
//  AniDebe
//
//  Created by prk on 1/10/23.
//

import Foundation

struct Anime: Codable {
    
    let malId: Int
    let url: String
    
    let type: String
    let episodes: Int?
    let status: String
    let airing: Bool
    let rating: String?
    let score: Double?
    let rank: Int?
    
    let season: String
    let year: Int
    
    let title: String
    let titleSynonyms: [String]
    let synopsis: String
    
    let images: Images
    let trailer: Trailer
    let genres: [Genre]
    let aired: Aired
    
}
