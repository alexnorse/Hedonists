//
//  AllPlacesMapVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/30/21.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate {
    
    var places = [Place]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let locationManager = CLLocationManager()
    
    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        fetchData()
        configureAnnotations()
        checkLocationServices()
    }
    
    
    func fetchData() {
        do {
            places = try context.fetch(Place.fetchRequest())
        } catch {
            presentAlert(title: AlertTitle.error, message: Errors.fetchError)
        }
    }

    
    func configureMapPosition() {
        let location = CLLocationCoordinate2D(latitude: 55.7582313, longitude: 37.5949771)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: UISettings.regionZoom, longitudinalMeters: UISettings.regionZoom)
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
        guard !(annotation is MKUserLocation)  else { return nil }
        
        let id = "Place"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            annotationView?.canShowCallout = true
            
            let infoButton = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = infoButton
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
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            presentAlert(title: AlertTitle.error, message: Alerts.locationServices)
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            presentAlert(title: AlertTitle.error, message: Alerts.locationServices)
            break
        case .denied:
            presentAlert(title: AlertTitle.error, message: Alerts.locationServices)
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            configureMapPosition()
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            break
        }
    }
}


extension MapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: UISettings.regionZoom, longitudinalMeters: UISettings.regionZoom)
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
