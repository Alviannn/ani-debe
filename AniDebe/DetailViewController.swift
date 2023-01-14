//
//  DetailViewController.swift
//  AniDebe
//
//  Created by prk on 13/01/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var AnimeImage: UIImageView!
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var ScoreText: UILabel!
    @IBOutlet weak var SeasonText: UILabel!
    @IBOutlet weak var EpisodeText: UILabel!
    @IBOutlet weak var SynopsisText: UITextView!
    
    var anime: Anime!
    var coverImage: UIImage!
    var animeId: Int!
    var check: Bool = false
    
    let favRepo = FavoriteRepository()
    var currentFavorite: Favorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        AnimeImage.image = coverImage
        TitleText.text = anime.title
        ScoreText.text = "Score : \(anime.score ?? 0)/10.0"
        SeasonText.text = "\(anime.season) Season"
        let episode = anime.episodes ?? 0
        let episodeString = episode != 0 ? "\(episode)" : "??"
        
        EpisodeText.text = "Total Episode : \(episodeString)"
        SynopsisText.text = anime.synopsis
        
        animeId = anime.malId
        
        currentFavorite = favRepo.findByMalId(id: anime.malId)
        if currentFavorite != nil {
            FavoriteButton.setTitle("Unfavorite", for: .normal)
            check = true
        }
    }
    
    @IBAction func FavoritePressed(_ sender: Any) {
        if(check){
            favRepo.delete(entity: currentFavorite!)
        }else{
            let favorite = favRepo.create()
            favorite.malId = Int64(animeId)

            favRepo.saveContext()
        }
        
        performSegue(withIdentifier: "toHome", sender: self)
    }
}
