//
//  FavoriteViewController.swift
//  AniDebe
//
//  Created by prk on 1/13/23.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var FavoriteAnimeTv: UITableView!
    var favoriteList = [Favorite]()
    
    let animeService = AnimeService(baseUrl: "https://api.jikan.moe/v4/anime")
    let favRepo = FavoriteRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        FavoriteAnimeTv.dataSource = self
        
        favoriteList = favRepo.getAll()
        self.refreshFavorites()
    }
    
    func refreshFavorites() {
        favoriteList = favRepo.getAll()
        FavoriteAnimeTv.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshFavorites()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = favoriteList[indexPath.row].malId
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteViewCell
        
        animeService.getId(id: Int(id), onComplete: { res, err in
            if let err = err{
                print(err)
                return
            }
            
            let anime = res!.data
            let imageUrl = anime.images.jpg.imageUrl
            
            URLSession.shared.loadUIImage(rawUrl: imageUrl, onComplete: { data, err in
                if err != nil {
                    // todo: do something when error
                    return
                }
                
                DispatchQueue.main.async {
                    cell.imageView!.image = UIImage(data: data!)
                    
                    cell.TitleText.text = anime.title
                    cell.ScoreText.text = "Score : \(anime.score ?? 0)/10.0"
                    
                    let episode = anime.episodes ?? 0
                    let episodeString = (episode != 0) ? "\(episode)" : "??"

                    cell.DescriptionTxt.text = "Total Episode: \(episodeString)\n\(anime.synopsis)"

                    // force the cell to load the image
                    //
                    // otherwise we need the user to start scrolling the app
                    // in order to load the images.
                    cell.setNeedsLayout()
                }
            }).resume()
        })
        
        return cell
    }
}
