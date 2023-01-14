//
//  ViewController.swift
//  AniDebe
//
//  Created by prk on 1/10/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var AnimeTv: UITableView!
    @IBOutlet var SearchBar: UISearchBar!
    
    var search: Bool = false
    var animeList = [Anime]()
    var animeListSearch = [Anime]()
    var tableSelected: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnimeTv.delegate = self
        AnimeTv.dataSource = self
        SearchBar.delegate = self
        
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
                self.animeListSearch = animeList
//                print("AnimeList global : \(self.animeList.count)")
//                print("TESTTTT \(self.animeList[0])")
                self.AnimeTv.reloadData()
            }
            
            for anime in animeList {
                count += 1
                print("\(count). \(anime.title) - \(anime.score ?? 0.00)")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeListSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let model = animeListSearch[row]
        
        let imageUrl = model.images.jpg.imageUrl
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnimeViewCell
        
        URLSession.shared.loadUIImage(rawUrl: imageUrl, onComplete: { data, err in
            if err != nil {
                // todo: do something when error
                return
            }
            
            DispatchQueue.main.async {
                cell.imageView!.image = UIImage(data: data!)
                cell.imageView!.layer.masksToBounds = true
                
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
        
        cell.imageView!.contentMode = .scaleAspectFill
        
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableSelected = indexPath
        print("Masuk sini gan")
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        animeListSearch = searchText.isEmpty ? animeList : animeList.filter { (item: Anime) -> Bool in
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        AnimeTv.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetail"){
            let dest = segue.destination as! DetailViewController
            dest.coverImage = AnimeTv.cellForRow(at: tableSelected!)!.imageView!.image
            dest.anime = animeListSearch[tableSelected!.row]
        }
    }
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {}
}
