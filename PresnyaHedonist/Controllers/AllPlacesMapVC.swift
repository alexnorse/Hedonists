//
//  AllPlacesMapVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/30/21.
//

import UIKit
import MapKit
import CoreLocation

class AllPlacesMapVC: UIViewController, MKMapViewDelegate {
    
    var places = [Place]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let locationManager = CLLocationManager()
    
    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        checkLocationServices()
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
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            
        }
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.isUserLocationVisible
            centerViewToUsersLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    
    func centerViewToUsersLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: UISettings.regionZoom, longitudinalMeters: UISettings.regionZoom)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func configureMap () {
        for location in places {
            let annotation = MKPointAnnotation()
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
            
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
}


extension AllPlacesMapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: UISettings.regionZoom, longitudinalMeters: UISettings.regionZoom)
        
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
