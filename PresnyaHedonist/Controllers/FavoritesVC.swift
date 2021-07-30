//
//  FavoritesVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var favorites = [Favorite]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        do {
            favorites = try context.fetch(Favorite.fetchRequest())
        } catch {
            presentAlert(title: AlertTitle.error,
                         message: Errors.faillURL)
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
        
        let favorite = Favorite()
        
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
            
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
