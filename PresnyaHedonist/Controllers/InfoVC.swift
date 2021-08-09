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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var type: UILabel!
    @IBOutlet var descript: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var workHours: UILabel!
    @IBOutlet var instagramLink: UIButton!
    @IBOutlet var addToFavorites: UIButton!
    
    
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
        
        place?.isFavorite = true
        
        do {
            try? context.save()
        } catch {
            presentAlert(title: AlertTitle.error,
                         message: Errors.favsFail)
        }
        
        presentAlert(title: AlertTitle.success,
                     message: Alerts.addedToFavorites)
    }
}
