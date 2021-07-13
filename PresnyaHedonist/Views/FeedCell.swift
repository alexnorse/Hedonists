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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
