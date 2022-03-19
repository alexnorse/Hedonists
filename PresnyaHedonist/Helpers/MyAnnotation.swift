//
//  MyAnnotation.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 9/9/21.
//

import UIKit
import MapKit

class MyAnnotation: MKPointAnnotation {
     let place: Place
     
     init(place: Place) {
          self.place = place
          super.init()
     }
}
