//
//  AllPlacesMapVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/30/21.
//

import UIKit
import MapKit
import CoreLocation

class MyAnnotation: MKPointAnnotation {
    let place: Place
    init(place: Place) {
        self.place = place
        super.init()
    }
}


class MapVC: UIViewController, MKMapViewDelegate {
    
    var places = [Place]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        fetchData()
        configureMap()
        configureAnnotations()
    }
    
    
    func fetchData() {
        do {
            places = try context.fetch(Place.fetchRequest())
            
        } catch {
            presentAlert(title: AlertTitle.error,
                         message: Errors.fetchError)
        }
    }

    
    func configureMap() {
        let location = CLLocationCoordinate2D(latitude: 55.7582313, longitude: 37.5949771)
        let region = MKCoordinateRegion(center: location,
                                        latitudinalMeters: UISettings.regionZoom,
                                        longitudinalMeters: UISettings.regionZoom)
        
        mapView.setRegion(region, animated: false)
    }
    
    
    func configureAnnotations() {
        for location in places {
            let annotation = MyAnnotation(place: location)
            annotation.title = location.name
            annotation.subtitle = location.category
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            
            mapView.addAnnotation(annotation)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let id = "Place"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            annotationView?.canShowCallout = true
            
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = view.annotation as? MyAnnotation else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: VControllersID.DETAILS_VC) as! DetailsVC
        detailVC.place = annotation.place
        
        detailVC.modalPresentationStyle = .automatic
        
        present(detailVC, animated: true, completion: nil)
    }
}
