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
        title = "Feed"
    }
    
    
    func fetchData() {
        do {
            places = try context.fetch(Place.fetchRequest())
        } catch {
            print(Errors.fetchError)
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
    
}
