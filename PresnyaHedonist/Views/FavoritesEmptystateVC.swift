//
//  FavoritesEmptystateVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/17/21.
//

import UIKit

class FavoritesEmptystateVC: UIViewController {

    @IBOutlet weak var emptyStateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designSettings()
    }
    
    
    func designSettings() {
        emptyStateLabel.font = Fonts.bodyAccents
        emptyStateLabel.text = EmptyStates.favsEmpty
    }
}
