//
//  DetailViewController.swift
//  AniDebe
//
//  Created by prk on 13/01/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var AnimeImage: UIImageView!
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var ScoreText: UILabel!
    @IBOutlet weak var SeasonText: UILabel!
    @IBOutlet weak var EpisodeText: UILabel!
    
    var anime: Anime!
    var coverImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        AnimeImage.image = coverImage
        TitleText.text = anime.title
        ScoreText.text = "Score : \(anime.score ?? 0)/10.0"
        
        let episode = anime.episodes ?? 0
        let episodeString = episode != 0 ? "\(episode)" : "??"
        
        EpisodeText.text = "Total Episode : \(episodeString)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
