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
    var title: String? // display lat, lon
    
    init(identifier: String, coordinate: CLLocationCoordinate2D, title: String?) {
        self.identifier = identifier
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
    
}
