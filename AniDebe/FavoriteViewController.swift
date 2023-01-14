//
//  FavoriteViewController.swift
//  AniDebe
//
//  Created by prk on 1/13/23.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var FavoriteAnimeTv: UITableView!
    var anime = [Anime]()
    var coverImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        FavoriteAnimeTv.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Counterssss : \(ViewController.fav.favoriteId.count)")
        
        return ViewController.fav.favoriteId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let baseUrl = "https://api.jikan.moe/v4"
        let animeService = AnimeService(baseUrl: "\(baseUrl)/anime")
        
        let id = ViewController.fav.favoriteId[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteViewCell
        
        animeService.getId(id: id, onComplete: { data, err in
            if let err = err{
                print(err)
                return
            }
            
            let anime = data!.data
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
