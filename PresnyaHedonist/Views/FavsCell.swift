//
//  FavsCell.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 8/28/21.
//

import UIKit

class FavsCell: UITableViewCell {

    @IBOutlet var placeName: UILabel!
    @IBOutlet var placeImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designSettings()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func designSettings() {
        placeName.font      = Fonts.headlines
        configureGradient()
    }
    
    
    func configureGradient() {
        let gradientLayer   = CAGradientLayer()
        let blackColor      = UIColor.black.cgColor
        let clearColor      = UIColor.clear.cgColor
        
        placeImage.layer.addSublayer(gradientLayer)
        
        gradientLayer.colors = [clearColor, blackColor]
        gradientLayer.frame = bounds
    }
}
