//
//  InfoVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import SafariServices
import CoreData
import CallKit

class InfoVC: UIViewController {
    
    var place: Place?
    var favorite = Favorite()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var workHours: UILabel!
    
    @IBOutlet weak var instagramLink: UIButton!
    @IBOutlet weak var addToFavorites: UIButton!
    
    
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
    }
    
    
    func designSettings() {
        type.font       = Fonts.bodyAccents
        descript.font   = Fonts.bodyText
        address.font    = Fonts.bodyAccents
        workHours.font  = Fonts.bodyAccents
    }
    
    
    @IBAction func phoneCall(_ sender: Any) {
        
        let formattedNumber = place?.phone?.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if let url = NSURL(string: ("tel:" + formattedNumber!)) {
            if #available(iOS 10, *) { UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else { UIApplication.shared.openURL(url as URL) }
        }
    }
    
    
    @IBAction func instagramLink(_ sender: Any) {
        
        guard let url = URL(string: place?.url ?? "https://www.instagram.com") else {
            
            presentAlert(title: AlertTitle.error,
                         message: Errors.faillURL)
            return
        }
        present(SFSafariViewController(url: url), animated: true)
    }
    
    
    @IBAction func addToFavoritesTapped(_ sender: Any) {
        
        let place = Place(context: context)
        let favorites = Favorite(context: context)
        
        do {
            favorites.addToFavorites(place)
            try context.save()
        } catch {
            presentAlert(title: AlertTitle.error,
                         message: Errors.favsFail)
        }
        

        presentAlert(title: AlertTitle.success,
                     message: Alerts.addedToFavorites)
    }
}
