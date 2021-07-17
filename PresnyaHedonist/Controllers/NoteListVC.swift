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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addnewNote: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        uiSettings()
        refresh()
    }
    
    
    func uiSettings() {
        addnewNote.titleLabel?.font = Fonts.buttons
    }
    
    
    func refresh() {
        
    }
    
    
    @IBAction func addNoteButton(_ sender: Any) {
        
    }
}
