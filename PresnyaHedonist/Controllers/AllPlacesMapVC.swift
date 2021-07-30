//
//  AllPlacesMapVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/30/21.
//

import UIKit
import MapKit

class AllPlacesMapVC: UIViewController {

    var places = [Place]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configureMap()
    }
    
    
    func fetchData() {
        do {
            places = try context.fetch(Place.fetchRequest())
            
        } catch {
            presentAlert(title: AlertTitle.error,
                         message: Errors.fetchError)
        }
    }
    
    
    func configureMap () {
        for location in places {
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            
            mapView.addAnnotation(annotation)
        }
        
        let centerLocation = CLLocationCoordinate2D(latitude: 55.7575463, longitude: 37.5860032)
        let region = MKCoordinateRegion(center: centerLocation, latitudinalMeters: UISettings.regionZoom, longitudinalMeters: UISettings.regionZoom)
        mapView.setRegion(region, animated: false)
    }
    
}
