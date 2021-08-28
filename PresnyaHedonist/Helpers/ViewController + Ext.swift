//
//  ViewController + Ext.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/24/21.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default))
            
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle   = .crossDissolve
            
            self.present(alert, animated: true)
        }
    }
}
