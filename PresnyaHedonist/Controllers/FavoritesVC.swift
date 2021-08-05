//
//  FavoritesVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchedFavs: NSFetchedResultsController<Place>
    
    required init?(coder aDecoder: NSCoder) {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES")
        
        fetchedFavs = NSFetchedResultsController(fetchRequest: request,
                                                 managedObjectContext: context,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
        super.init(coder: aDecoder)
    }
    
    
    @IBOutlet var favoritesTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTable.delegate = self
        favoritesTable.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureController()
        designSettings()
    }
    
    
    func configureController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = ([NSAttributedString.Key.font: Fonts.vcHeads!])
        title = VCTitles.favsTitle
    }
    
    
    func designSettings() {
        favoritesTable.removeExcessCells()
    }

}


extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedFavs.fetchedObjects?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.FAVS_CELL, for: indexPath)
        
        cell.textLabel?.text        = fetchedFavs.object(at: indexPath).name
        cell.detailTextLabel?.text  = fetchedFavs.object(at: indexPath).category

        cell.textLabel?.font        = Fonts.bodyAccents
        cell.detailTextLabel?.font  = Fonts.bodyText
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive,
                                        title: "Delete") { (action, view, nil) in
            
            DispatchQueue.main.async { self.favoritesTable.reloadData() }
            
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
