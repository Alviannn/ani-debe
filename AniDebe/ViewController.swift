//
//  ViewController.swift
//  AniDebe
//
//  Created by prk on 1/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseUrl = "https://api.jikan.moe/v4"
        let sessionService = SessionService(baseUrl: "\(baseUrl)/seasons")
        
        sessionService.currentSeason(page: 1, onCompleteHandler: { data, err in
            if let err = err {
                print(err)
                return
            }
            
            let animeList = data!.data
            var count = 0
            
            for anime in animeList {
                count += 1
                print("\(count). \(anime.title) - \(anime.score ?? 0.00)")
            }
        })
        
        // Do any additional setup after loading the view.
    }


}

