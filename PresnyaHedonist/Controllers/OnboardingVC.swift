//
//  OnboardingVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/15/21.
//

import UIKit

class OnboardingVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var greetings: UITextView!
    @IBOutlet weak var welcomeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSettings()
    }
    
    
    func uiSettings() {
        greetings.font = Fonts.bodyAccents
        welcomeButton.titleLabel?.font = Fonts.buttons
    }
    
    
    @IBAction func welcomeTapped(_ sender: Any) {
        
    }
}
