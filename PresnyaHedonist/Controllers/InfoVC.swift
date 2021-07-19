//
//  InfoVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import SafariServices
import CoreData

class InfoVC: UIViewController {
    
    var place: Place?
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var workHours: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var addToFavsButton: UIButton!
    @IBOutlet weak var instagramLink: UIButton!
    @IBOutlet weak var addToFavs: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureContent()
        designSettings()
    }
    
    
    func configureContent() {
        type.text       = place?.category
        descript.text   = place?.descript
        address.text    = place?.address
        workHours.text  = place?.workhours
        phone.text      = place?.phone
    }
    
    
    func designSettings() {
        type.font = Fonts.bodyAccents
        descript.font = Fonts.bodyText
        address.font = Fonts.bodyAccents
        workHours.font = Fonts.bodyAccents
        phone.font = Fonts.bodyAccents
        instagramLink.titleLabel?.font = Fonts.buttons
        addToFavs.titleLabel?.font = Fonts.buttons
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
        let alert = UIAlertController(title: "♥️",
                                      message: Alerts.addToFavs,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default))
        
        present(alert, animated: true)
    }
}
