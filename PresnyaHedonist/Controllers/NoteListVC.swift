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
        addnewNote.titleLabel?.font = Fonts.buttons
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
            } catch {}
        }
        tableView.reloadData()
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
        fetchedNotes?.fetchedObjects?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.NOTES_CELL, for: indexPath)
        
        let noteText = cell.viewWithTag(1) as! UILabel
        let date = cell.viewWithTag(2) as! UILabel
        
        let note = fetchedNotes?.object(at: indexPath)
        if let note = note {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            
            noteText.text = note.text
            date.text = dateFormatter.string(from: note.date!)
        }
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
