//
//  MapViewController.swift
//  Mapic
//
//  Created by Jawaher Alagel on 11/30/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Properties

    var manager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus() //TODO: find replacement

    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        manager.delegate = self
        configureLocationServices()
        
    }

    // MARK: - Helpers


}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
        
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            manager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
}
