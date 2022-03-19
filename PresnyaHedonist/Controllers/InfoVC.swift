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
     
     
     @IBOutlet var descript: UILabel!
     @IBOutlet var address: UILabel!
     @IBOutlet var workHours: UILabel!
     @IBOutlet var buttons: [UIButton]!
     
     
     override func viewDidLoad() {
          super.viewDidLoad()
     }
     
     
     override func viewWillAppear(_ animated: Bool) {
          configureContent()
          designSettings()
     }
     
     
     private func configureContent() {
          descript.text   = place?.descript
          address.text    = place?.address
          workHours.text  = place?.workhours
     }
     
     
     private func designSettings() {
          descript.font   = Fonts.bodyText
          address.font    = Fonts.bodyAccents
          workHours.font  = Fonts.bodyAccents
          
          for button in buttons {
               button.layer.cornerRadius = 25
          }
     }
     
     
     @IBAction func phoneCall(_ sender: Any) {
          if place?.phone != nil {
               let formattedNumber = place?.phone?.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
               
               if let url = NSURL(string: ("tel:" + "+" + formattedNumber!)) {
                    if #available(iOS 10, *) { UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                    } else { UIApplication.shared.openURL(url as URL) }
               }
               
          } else { presentAlert(title: AlertTitle.error, message: Errors.phoneError) }
     }
     
     
     @IBAction func instagramLink(_ sender: Any) {
          guard let url = URL(string: place?.url ?? "https://www.instagram.com") else {
               presentAlert(title: AlertTitle.error, message: Errors.faillURL)
               return
          }
          present(SFSafariViewController(url: url), animated: true)
     }
     
     
     @IBAction func addToFavoritesTapped(_ sender: Any) {
          place?.isFavorite = true
          try? context.save()
          presentAlert(title: AlertTitle.success, message: Alerts.addedToFavorites)
     }
}
