//
//  AnimeService.swift
//  AniDebe
//
//  Created by prk on 1/13/23.
//

import Foundation

class AnimeService: BaseJikanService{

    func getId(id: Int, onComplete: @escaping CompleteHandler<Anime>){
        self.fetchFromUrl(stringUrl: "\(baseUrl)/\(id)", onCompleteHandler: onComplete)
    }
    
}
