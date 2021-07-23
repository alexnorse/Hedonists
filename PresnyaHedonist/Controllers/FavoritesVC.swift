//
//  FavoritesVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit

class FavoritesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureController()
    }
    
    
    func configureController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = ([NSAttributedString.Key.font: Fonts.vcHeads!])
        title = VCTitles.favsTitle
    }
}
