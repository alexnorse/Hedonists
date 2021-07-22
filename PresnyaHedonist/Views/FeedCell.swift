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
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designSettings()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func designSettings() {
        placeImage.layer.cornerRadius       = UISettings.cornerRadius
        placeName.font                      = Fonts.headlines
        typeLabel.font                      = Fonts.bodyAccents
        configureGradient()
    }
    
    
    func configureGradient() {
        let gradientLayer   = CAGradientLayer()
        
        let blackColor      = UIColor.black.cgColor
        let clearColor      = UIColor.clear.cgColor
        
        gradientLayer.colors = [
            clearColor,
            blackColor
        ]
        
        placeImage.layer.addSublayer(gradientLayer)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = UISettings.cornerRadius
    }
    
    
    func setCell(_ place: Place) {
        placeImage.image    = UIImage(named: place.image!)
        placeName.text      = place.name
        typeLabel.text      = place.category
    }
}
