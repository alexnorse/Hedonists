//
//  FavoritesVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {
    
    var favorites = [Favorite]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedFavs: NSFetchedResultsController<Favorite>?
    
    @IBOutlet var favoritesTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTable.delegate = self
        favoritesTable.dataSource = self
        
        configureController()
        designSettings()
        
        fetchData()
    }
    
    
    func configureController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = ([NSAttributedString.Key.font: Fonts.vcHeads!])
        title = VCTitles.favsTitle
    }
    
    
    func designSettings() {
        favoritesTable.removeExcessCells()
    }
    
    
    func fetchData() {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            favorites = try context.fetch(request)
        } catch {
            presentAlert(title: AlertTitle.error,
                         message: Errors.fetchError)
        }
        
        DispatchQueue.main.async {
            self.favoritesTable.reloadData()
            if self.favorites.count == 0 {
                self.favoritesTable.setEmptyState(EmptyStates.favsEmpty)
            } else {
                self.favoritesTable.restore()
            }
        }
    }
}


extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.FAVS_CELL, for: indexPath)
        
        let favorite = favorites[indexPath.row]
        
        cell.textLabel?.text        = favorite.name
        cell.detailTextLabel?.text  = favorite.category

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
            
            if self.fetchedFavs == nil { return }
            
            let favorite = self.fetchedFavs!.object(at: indexPath)
            self.context.delete(favorite)
            self.appDelegate.saveContext()
            self.fetchData()
            
            DispatchQueue.main.async { self.favoritesTable.reloadData() }
            
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
