//
//  MapVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit
import MapKit

class PlaceMapVC: UIViewController, MKMapViewDelegate {
    
    var place: Place?
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureMap()
        configureAnnotation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    func configureMap() {
        guard place == nil else {
            let location = CLLocationCoordinate2D(latitude: place!.lat, longitude: place!.long)
            let region = MKCoordinateRegion(center: location,
                                            latitudinalMeters: UISettings.regionZoomDetails,
                                            longitudinalMeters: UISettings.regionZoomDetails)
            
            mapView.setRegion(region, animated: false)
            return
        }
    }
    
    
    func configureAnnotation() {
        guard place == nil else {
            let annotation = MyAnnotation(place: place!)
            annotation.coordinate = CLLocationCoordinate2D(latitude: place!.lat, longitude: place!.long)
            mapView.addAnnotation(annotation)
            return
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let id = "Place"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}
