//
//  FavoritesVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {

    @IBOutlet weak var tableViewFavorites: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
    }
    
    
    func configureController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Titles.favsTitle
    }
}
