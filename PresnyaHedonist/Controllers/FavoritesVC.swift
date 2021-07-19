//
//  FavoritesVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController, UITableViewDelegate {

    var favPlaces: [Place]?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableViewFavorites: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewFavorites.delegate = self
        tableViewFavorites.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureController()
        fetchFavs()
    }
    
    
    func configureController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Titles.favsTitle
    }
    
    
    func fetchFavs() {
        do {
            let request = Place.fetchRequest() as NSFetchRequest<Place>
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]
            favPlaces = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.tableViewFavorites.reloadData()
            }
 
        } catch {}
    }
}


extension FavoritesVC: UITabBarDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.favPlaces?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFavorites.dequeueReusableCell(withIdentifier: CellsID.FAVORITES_CELL, for: indexPath)
        let place = self.favPlaces?[indexPath.row]
        
        let placeName = cell.viewWithTag(1) as! UILabel
        let placeType = cell.viewWithTag(2) as! UILabel
        
        placeName.text = place?.name
        placeType.text = place?.category
        
        return cell
    }
}
