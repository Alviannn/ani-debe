//
//  ViewController.swift
//  AniDebe
//
//  Created by prk on 1/10/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var AnimeTv: UITableView!
    var animeList = [Anime]()
    
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
        print("Count : \(animeList.count)")
        return animeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = animeList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnimeViewCell
        let url = model.images.jpg.imageUrl
//        cell.AnimeImage.image = UIImage(data: URL(string: url))
        cell.TitleText.text = model.title
        cell.ScoreText.text = "Score : \(model.score ?? 0)/10.0"
        
        return cell
        
    }
    
}

extension UIImageView {
    func loadFrom(URLAddress: String){
        guard let url = URL(string: URLAddress) else{
            return
        }
        DispatchQueue.main.async {[weak self] in
            if let imageData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imageData){
                    self?.image = loadedImage
                }
            }
        }
    }
    
}
