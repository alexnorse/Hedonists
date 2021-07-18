//
//  NotesEmptystateVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/17/21.
//

import UIKit

class NotesEmptystateVC: UIViewController {
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designSettings()
    }
    
    
    func designSettings() {
        emptyLabel.font = Fonts.bodyAccents
        emptyLabel.text = EmptyStates.notesEmpty
    }

}
