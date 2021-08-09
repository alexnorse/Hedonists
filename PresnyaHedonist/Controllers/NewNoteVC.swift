//
//  NewNoteVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import CoreData

protocol NewNoteDelegate {
    func noteAdded()
}

class NewNoteVC: UIViewController {
    
    var place: Place?
    var delegate: NewNoteDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var noteView: UIView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var save: UIButton!
    @IBOutlet var close: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designSettings()
    }
    
    
    func designSettings() {
        view.backgroundColor            = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        noteView.layer.cornerRadius     = UISettings.cornerRadius
        noteView.layer.shadowOpacity    = 1
        noteView.layer.shadowOffset     = .zero
        noteView.layer.shadowRadius     = 5
        
        textView.font = Fonts.bodyText
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        let note = Note(context: context)
        
        guard let noteText = textView.text, !noteText.isEmpty else {
            return
        }
        
        note.date   = Date()
        note.text   = noteText
        note.place  = place
        
        appDelegate.saveContext()
        delegate?.noteAdded()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
