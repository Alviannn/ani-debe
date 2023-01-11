//
//  SeasonService.swift
//  AniDebe
//
//  Created by prk on 1/10/23.
//

import Foundation

class SessionService: BaseJikanService {
        
    func currentSeason(page: Int = 1, onCompleteHandler: @escaping CompletePaginatedHandler<Anime>) {
        self.fetchPaginatedFromUrl(
            stringUrl: "\(baseUrl)/now?page=\(page)",
            onCompleteHandler: onCompleteHandler
        )
    }
    
}
