//
//  MapVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    
    var place: Place?
    
    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureMap()
    }
    
    
    func configureMap() {
        if place != nil {
            let location = CLLocationCoordinate2D(latitude: place!.lat, longitude: place!.long)
            let pin = MKPointAnnotation()
            let region = MKCoordinateRegion(center: location,
                                            latitudinalMeters: UISettings.regionZoomDetails,
                                            longitudinalMeters: UISettings.regionZoomDetails)
            
            pin.coordinate = location
            
            mapView.addAnnotation(pin)
            mapView.setRegion(region, animated: false)
        }
    }
}
