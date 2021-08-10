//
//  FavoritesVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {
    
    var place: Place?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchedFavs: NSFetchedResultsController<Place>
    
    @IBOutlet var favoritesTable: UITableView!
    
    
    required init?(coder aDecoder: NSCoder) {
        
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        fetchedFavs = NSFetchedResultsController(fetchRequest: request,
                                                 managedObjectContext: context,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
        
        try? fetchedFavs.performFetch()
        
        super.init(coder: aDecoder)
        fetchedFavs.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTable.delegate = self
        favoritesTable.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureController()
        designSettings()
        
        if self.fetchedFavs.fetchedObjects?.count == 0 {
            self.favoritesTable.setEmptyState(EmptyStates.favsEmpty)
        } else {
            self.favoritesTable.restore()
        }
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
        return fetchedFavs.fetchedObjects?.count ?? 0
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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: VControllersID.DETAILS_VC) as! DetailsVC
        detailVC.place = fetchedFavs.fetchedObjects?[indexPath.row]
        
        detailVC.modalPresentationStyle = .automatic
        present(detailVC, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive,
                                        title: "Delete") { (action, view, nil) in
            
            self.place = self.fetchedFavs.object(at: indexPath)
            self.place?.isFavorite = false
            try? self.context.save()
            try? self.fetchedFavs.performFetch()
            
            DispatchQueue.main.async { self.favoritesTable.reloadData() }
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}


extension FavoritesVC: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoritesTable.beginUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                favoritesTable.insertRows(at: [indexPath], with: .fade)
            }
            
        case .delete:
            favoritesTable.deleteRows(at: [indexPath! as IndexPath], with: .fade)
            break;
            
        default:
            print(" ")
        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoritesTable.endUpdates()
    }
    
}
