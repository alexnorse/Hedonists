//
//  NoteListVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import CoreData

class NoteListVC: UIViewController {
    
    var place: Place?
    var notes: [Note]?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedNotes: NSFetchedResultsController<Note>?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addnewNote: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        designSettings()
        refresh()
    }
    
    
    func designSettings() {
        addnewNote.layer.cornerRadius = UISettings.cornerRadius
        tableView.removeExcessCells()
    }
    
    
    func refresh() {
        if let place = place {
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            request.predicate = NSPredicate(format: "place = %@", place)
            
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            
            do {
                fetchedNotes = NSFetchedResultsController(fetchRequest: request,
                                                          managedObjectContext: context,
                                                          sectionNameKeyPath: nil,
                                                          cacheName: nil)
                try fetchedNotes?.performFetch()
            } catch {
                let alert = UIAlertController(title: AlertTitle.error,
                                              message: Errors.fetchError,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok",
                                              style: .default))
                
                DispatchQueue.main.async { self.present(alert, animated: true) }
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.fetchedNotes?.fetchedObjects?.count == 0 {
                self.tableView.setEmptyState(EmptyStates.notesEmpty)
            } else {
                self.tableView.restore()
            }
        }
    }
    
    
    @IBAction func addNoteButton(_ sender: Any) {
        let newNoteVC = storyboard?.instantiateViewController(identifier: VControllersID.NEWNOTE_VC) as! NewNoteVC
        newNoteVC.delegate = self
        newNoteVC.place = place
        newNoteVC.modalPresentationStyle = .overCurrentContext
        present(newNoteVC, animated: true, completion: nil)
    }
}


extension NoteListVC: NewNoteDelegate {
    func noteAdded () {
        refresh()
    }
}


extension NoteListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedNotes?.fetchedObjects?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.NOTES_CELL, for: indexPath)
        
        let note = fetchedNotes?.object(at: indexPath)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        cell.textLabel?.text = note?.text
        cell.textLabel?.font = Fonts.bodyAccents
        
        cell.detailTextLabel?.text = dateFormatter.string(from: (note?.date)!)
        cell.detailTextLabel?.font = Fonts.bodyText
        cell.detailTextLabel?.textColor = .secondaryLabel
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive,
                                        title: "Delete") { (action, view, nil) in
            
            if self.fetchedNotes == nil {
                return
            }
            
            let note = self.fetchedNotes!.object(at: indexPath)
            self.context.delete(note)
            self.appDelegate.saveContext()
            self.refresh()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
