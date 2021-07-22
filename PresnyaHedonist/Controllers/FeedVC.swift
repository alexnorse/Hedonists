//
//  FeedVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit

class FeedVC: UIViewController {
    
    var places = [Place]()
    var filteredPlaces = [Place]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableViewFeed: UITableView!
    
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewFeed.delegate = self
        tableViewFeed.dataSource = self
        tableViewFeed.tableSeparator()
        
        configureController()
        configureSearchController()
        fetchData()
    }
    
    
    func configureController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Fonts.vcHeads!]
        title = Titles.feedTitle
    }
    
    
    func fetchData() {
        do {
            places = try context.fetch(Place.fetchRequest())
        } catch {
            let alert = UIAlertController(title: AlertTitle.error,
                                          message: Errors.faillURL,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default))
            
            DispatchQueue.main.async { self.present(alert, animated: true) }
        }
    }
    
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Поиск..."
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if tableViewFeed.indexPathForSelectedRow == nil {
            return
        }
        
        if let indexPath = tableViewFeed.indexPathForSelectedRow {
            
            var place: Place
            
            if isFiltering { place = filteredPlaces[indexPath.row] }
            else { place = places[indexPath.row] }
            
            let destination = segue.destination as! DetailsVC
            destination.place = place
        }
    }
}


extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering { return filteredPlaces.count }
        return places.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.FEED_CELL) as! FeedCell
        
        var place: Place
        
        if isFiltering { place = filteredPlaces[indexPath.row] }
        else { place = places[indexPath.row] }
        
        cell.setCell(place)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewFeed.deselectRow(at: indexPath, animated: true)
    }
}


extension FeedVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        contentFilter(searchController.searchBar.text!)
    }
    
    
    func contentFilter(_ searchText: String) {
        filteredPlaces = places.filter { ($0.name?.lowercased().contains(searchText.lowercased()))! }
        DispatchQueue.main.async { self.tableViewFeed.reloadData() }
    }
}
