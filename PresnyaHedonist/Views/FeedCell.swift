//
//  FeedCell.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var placeName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uiSettings()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func uiSettings() {
        containerView.layer.cornerRadius = UISettings.cornerRadius
        
        shadowView.layer.cornerRadius = UISettings.cornerRadius
        shadowView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    
    func setCell(_ place: Place) {
        placeImage.image = UIImage(named: "placeholder")
        placeName.text = place.name
    }
    
}
