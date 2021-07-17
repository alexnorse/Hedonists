//
//  InfoVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import SafariServices

class InfoVC: UIViewController {
    
    var place: Place?
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var workHours: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var addToFavsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureContent()
    }
    
    
    func configureContent() {
        type.text = place?.category
        descript.text = place?.descript
        address.text = place?.address
        workHours.text = place?.workhours
        phone.text = place?.phone
    }
    
    
    @IBAction func instagramLink(_ sender: Any) {
        guard let url = URL(string: place?.url ?? "https://www.instagram.com") else {
            let alert = UIAlertController(title: "Упс☹️",
                                          message: Errors.faillURL,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default))
            
            present(alert, animated: true)
            
            return
        }
        present(SFSafariViewController(url: url), animated: true)
    }
    
    
    @IBAction func addToFavsTapped(_ sender: Any) {
        
    }
}
