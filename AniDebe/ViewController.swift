//
//  ViewController.swift
//  AniDebe
//
//  Created by prk on 1/10/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var AnimeTv: UITableView!
    @IBOutlet weak var SearchText: UITextField!
    var search: Bool = false
    var animeList = [Anime]()
    var animeListSearch = [Anime]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        AnimeTv.delegate = self
        AnimeTv.dataSource = self
        
        let baseUrl = "https://api.jikan.moe/v4"
        let sessionService = SessionService(baseUrl: "\(baseUrl)/seasons")
        
        sessionService.currentSeason(page: 1, onCompleteHandler: { data, err in
            if let err = err {
                print(err)
                return
            }
            
            let animeList = data!.data
            var count = 0
            
            
            
            DispatchQueue.main.async {
                print("Masuk dispatch")
                self.animeList = animeList
                print("AnimeList global : \(self.animeList.count)")
                print("TESTTTT \(self.animeList[0])")
                self.AnimeTv.reloadData()
            }
            
            for anime in animeList {
                count += 1
                print("\(count). \(anime.title) - \(anime.score ?? 0.00)")
                
                
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
        
        if(search){
            model = animeListSearch[indexPath.row]
        }else{
            model = animeList[indexPath.row]
        }
        
        let imageUrl = model.images.jpg.imageUrl
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnimeViewCell
        
        loadImageFromUrl(rawUrl: imageUrl, onComplete: { image, err in
            if err != nil {
                // todo: do something when error
                return
            }
            
            cell.imageView!.image = image
        })
        
//        DispatchQueue.main.async {
//            let url = URL(string: model.images.jpg.imageUrl)
//            let data = try? Data(contentsOf: url!)
//            cell.AnimeImage.image = UIImage(data: data!)
//        }
        cell.TitleText.text = model.title
        cell.ScoreText.text = "Score : \(model.score ?? 0)/10.0"
        let episode = model.episodes ?? 0
        let episodeString = episode != 0 ? "\(episode)" : "??"
        cell.DescriptionText.text = "Total Episode: \(episodeString)\n\(model.synopsis)"
        
        
        
        return cell
        
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
        let dest = segue.destination as! 
    }
}
