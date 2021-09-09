//
//  DetailsVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit

class DetailsVC: UIViewController {
    
    var place: Place?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var placeName: UILabel!
    @IBOutlet var placeType: UILabel!
    @IBOutlet var infoSegments: UISegmentedControl!
    @IBOutlet var containerView: UIView!
    
    
    lazy var infoViewController: InfoVC = {
        let infoVC = storyboard?.instantiateViewController(identifier: VControllersID.INFO_VC) as! InfoVC
        return infoVC
    } ()
    
    lazy var mapViewController: PlaceMapVC = {
        let mapVC = storyboard?.instantiateViewController(identifier: VControllersID.PLACEMAP_VC) as! PlaceMapVC
        return mapVC
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureContent()
        designSettings()
        segmentChange(self.infoSegments)
    }
    
    
    func configureContent() {
        imageView.image = UIImage(named: place?.image ?? Errors.imageError)
        placeName.text = place?.name
        placeType.text = place?.category
    }
    
    
    func designSettings() {
        placeName.font = Fonts.headlines
        placeType.font = Fonts.bodyAccents
    }
    
    
    private func switchVC(_ childVC: UIViewController) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childVC.didMove(toParent: self)
    }
    
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            infoViewController.place = self.place
            switchVC(infoViewController)
            
        case 1:
            mapViewController.place = self.place
            switchVC(mapViewController)
            
        default:
            switchVC(infoViewController)
        }
    }
}
