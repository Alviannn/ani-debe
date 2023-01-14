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
    
    func findByMalId(id: Int) -> Favorite? {
        let malId = Int64(id)
        
        let request = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "malId = %d", malId)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("Failed to fetch malId \(id): \(error)")
        }
        
        return nil
    }
    
}
