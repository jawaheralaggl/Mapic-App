//
//  MapViewController.swift
//  Mapic
//
//  Created by Jawaher Alagel on 11/30/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var manager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

