//
//  FeedVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit

class FeedVC: UIViewController {
    
    var places = [Place]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableViewFeed: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewFeed.delegate = self
        tableViewFeed.dataSource = self
        
        configureController()
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if tableViewFeed.indexPathForSelectedRow == nil {
            return
        }
        
        let selectedPlace = places[tableViewFeed.indexPathForSelectedRow!.row]
        let destination = segue.destination as! DetailsVC
        destination.place = selectedPlace
    }
}


extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.FEED_CELL) as! FeedCell
        
        let place = places[indexPath.row]
        cell.setCell(place)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewFeed.deselectRow(at: indexPath, animated: true)
    }
}
