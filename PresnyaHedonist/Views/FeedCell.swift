//
//  FeedCell.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uiSettings()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func uiSettings() {
        placeImage.layer.cornerRadius = UISettings.cornerRadius
        placeName.font = Fonts.headlines
    }
    
    
    func setCell(_ place: Place) {
        placeImage.image = UIImage(named: "placeholder")
        placeName.text = place.name
    }
}
