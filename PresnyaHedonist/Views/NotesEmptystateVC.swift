//
//  NotesEmptystateVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/17/21.
//

import UIKit

class NotesEmptystateVC: UIViewController {
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var addNoteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSettings()
    }
    
    
    func uiSettings() {
        emptyLabel.font = Fonts.bodyAccents
        addNoteButton.titleLabel?.font = Fonts.buttons
    }
    
    
    @IBAction func addNoteTapped(_ sender: Any) {
        
    }
}
