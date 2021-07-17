//
//  NewNoteVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit

class NewNoteVC: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var close: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uiSettings()
    }
    
    
    func uiSettings() {
        textView.font = Fonts.bodyText
        save.titleLabel?.font = Fonts.buttons
        close.titleLabel?.font = Fonts.buttons
    }

    
    @IBAction func saveButton(_ sender: Any) {
        
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        
    }
}
