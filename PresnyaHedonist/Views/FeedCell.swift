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
        designSettings()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func designSettings() {
        placeImage.layer.cornerRadius = UISettings.cornerRadius
        placeName.font = Fonts.headlines
    }
    
    
    func setCell(_ place: Place) {
        placeImage.image = UIImage(named: place.image!)
        placeName.text = place.name
    }
}
