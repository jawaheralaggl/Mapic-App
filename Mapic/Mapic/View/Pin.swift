//
//  Pin.swift
//  Mapic
//
//  Created by Jawaher Alagel on 12/3/20.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    var identifier: String
    var coordinate: CLLocationCoordinate2D
    
    init(identifier: String, coordinate: CLLocationCoordinate2D) {
        self.identifier = identifier
        self.coordinate = coordinate
        super.init()
    }
    
}
