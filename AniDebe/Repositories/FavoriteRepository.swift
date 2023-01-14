//
//  FavoriteRepository.swift
//  AniDebe
//
//  Created by prk on 1/13/23.
//

import Foundation

class FavoriteRepository: BaseRepository<Favorite> {
    
    init() {
        super.init(entityName: "Favorite")
    }
    
}
