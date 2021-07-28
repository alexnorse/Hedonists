//
//  Formap.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/28/21.
//

import UIKit
import MapKit

class ForMap: NSObject, MKAnnotation {
    
    var category: String
    var name: String
    var coordinate: CLLocationCoordinate2D
    
    internal init(category: String, name: String, coordinate: CLLocationCoordinate2D) {
        self.category = category
        self.name = name
        self.coordinate = coordinate
    }

}
