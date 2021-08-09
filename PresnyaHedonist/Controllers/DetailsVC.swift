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
    @IBOutlet var infoSegments: UISegmentedControl!
    @IBOutlet var containerView: UIView!
    
    
    lazy var infoViewController: InfoVC = {
        let infoVC = storyboard?.instantiateViewController(identifier: VControllersID.INFO_VC) as! InfoVC
        return infoVC
    } ()
    
    lazy var mapViewController: MapVC = {
        let mapVC = storyboard?.instantiateViewController(identifier: VControllersID.MAP_VC) as! MapVC
        return mapVC
    } ()
    
    lazy var noteListViewController: NoteListVC = {
        let noteListVC = storyboard?.instantiateViewController(identifier: VControllersID.NOTELIST_VC) as! NoteListVC
        return noteListVC
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = UIImage(named: place?.image ?? Errors.imageError)
        placeName.text = place?.name
        
        designSettings()
        segmentChange(self.infoSegments)
    }
    
    
    func designSettings() {
        placeName.font = Fonts.headlines
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
            
        case 2:
            noteListViewController.place = self.place
            switchVC(noteListViewController)
            
        default:
            switchVC(infoViewController)
        }
    }
}
