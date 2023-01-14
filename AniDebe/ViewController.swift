//
//  ViewController.swift
//  AniDebe
//
//  Created by prk on 1/10/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var AnimeTv: UITableView!
    @IBOutlet weak var SearchText: UITextField!
    var search: Bool = false
    var animeList = [Anime]()
    var animeListSearch = [Anime]()
    var tableSelected: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimeTv.delegate = self
        AnimeTv.dataSource = self
        
        let baseUrl = "https://api.jikan.moe/v4"
        let sessionService = SessionService(baseUrl: "\(baseUrl)/seasons")
        
        sessionService.currentSeason(page: 1, onCompleteHandler: { data, err in
            if let err = err {
                print(err)
                return
            }
            
            let animeList = data!.data
            DispatchQueue.main.async {
                self.animeList = animeList
                self.AnimeTv.reloadData()
            }
        })
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (search){
            return animeListSearch.count
        }
        return animeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model: Anime!
        let row = indexPath.row
        
        if(search){
            model = animeListSearch[row]
        }else{
            model = animeList[row]
        }
        
        let imageUrl = model.images.jpg.imageUrl
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnimeViewCell
        
        URLSession.shared.loadUIImage(rawUrl: imageUrl, onComplete: { data, err in
            if err != nil {
                // todo: do something when error
                return
            }
            
            DispatchQueue.main.async {
                cell.imageView!.image = UIImage(data: data!)
                
                cell.TitleText.text = model.title
                cell.ScoreText.text = "Score : \(model.score ?? 0)/10.0"
                
                let episode = model.episodes ?? 0
                let episodeString = (episode != 0) ? "\(episode)" : "??"

                cell.DescriptionText.text = "Total Episode: \(episodeString)\n\(model.synopsis)"
                
                // force the cell to load the image
                //
                // otherwise we need the user to start scrolling the app
                // in order to load the images.
                cell.setNeedsLayout()
            }
        }).resume()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableSelected = indexPath
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    @IBAction func SearchPressed(_ sender: Any) {
        let text: String = SearchText.text!
        animeListSearch.removeAll()
        
        if(!text.isEmpty){
            for anime in animeList{
                if(anime.title.contains(text)){
                    animeListSearch.append(anime)
                }
            }
            
            search = true
        }else{
            search = false
        }
        
        self.AnimeTv.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetail"){
            let dest = segue.destination as! DetailViewController
            let row = tableSelected!.row

            dest.coverImage = AnimeTv.cellForRow(at: tableSelected!)!.imageView!.image
    
            if(search){
                dest.anime = animeListSearch[row]
            }else{
                dest.anime = animeList[row]
            }
        }
    }
}
