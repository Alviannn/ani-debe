//
//  FavoriteViewCell.swift
//  AniDebe
//
//  Created by prk on 1/13/23.
//

import UIKit

class FavoriteViewCell: UITableViewCell {

    @IBOutlet weak var AnimeImage: UIImageView!
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var DescriptionTxt: UILabel!
    @IBOutlet weak var ScoreText: UILabel!
    var descText: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
