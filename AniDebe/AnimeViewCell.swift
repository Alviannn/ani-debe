//
//  AnimeViewCell.swift
//  AniDebe
//
//  Created by prk on 1/11/23.
//

import UIKit

class AnimeViewCell: UITableViewCell {

    @IBOutlet weak var AnimeImage: UIImageView!
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var ScoreText: UILabel!
    @IBOutlet weak var DescriptionText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
