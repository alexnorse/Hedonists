//
//  FavoritesVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController, UITableViewDelegate {
    
    var place: Place?
    
    var fetchedPlaces: NSFetchedResultsController<Place>?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableViewFavorites: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewFavorites.delegate = self
        tableViewFavorites.dataSource = self
        tableViewFavorites.removeExcessCells()
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
        if let place = place {
            let request: NSFetchRequest<Place> = Place.fetchRequest()
            let sort = NSSortDescriptor(key: "name", ascending: false)
            request.sortDescriptors = [sort]
            do {
                fetchedPlaces = NSFetchedResultsController(fetchRequest: request,
                                                           managedObjectContext: context,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)
                try fetchedPlaces?.performFetch()
                
            } catch {}
        }
        DispatchQueue.main.async {
            self.tableViewFavorites.reloadData()
        }
    }
}


extension FavoritesVC: UITabBarDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedPlaces?.fetchedObjects?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFavorites.dequeueReusableCell(withIdentifier: CellsID.FAVORITES_CELL, for: indexPath)
        let place = fetchedPlaces?.object(at: indexPath)
        
        let placeName = cell.viewWithTag(1) as! UILabel
        let placeType = cell.viewWithTag(2) as! UILabel
        
        placeName.text = place?.name
        placeType.text = place?.category
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewFavorites.deselectRow(at: indexPath, animated: true)
    }
}
