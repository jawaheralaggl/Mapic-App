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
        
        // map view properties
        mapView.delegate = self
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        
        configureLocationServices()
        
        // location manager properties
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
        
    }
    
    // MARK: - Helpers
    
    
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    // set the region to center the map on user location
    func zoomInUserLocation() {
        guard let coordinate = manager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000 , longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        zoomInUserLocation()
    }
    
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            manager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
}
