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
    
    let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Standard", "Satellite", "Hybrid"])
        segmented.selectedSegmentIndex = 0
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.addTarget(self, action: #selector(changeType(_:)), for: .valueChanged)
        return segmented
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(segmentedControl)
        configurUI()
        
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
    
    // MARK: -
    
    // switch on map type
    @objc func changeType(_ sgmtControl: UISegmentedControl) {
        switch sgmtControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            print("type not found")
            break
        }
        
    }
    
    // MARK: - Helpers
    
    func configurUI() {
        let margin = view.layoutMarginsGuide
        
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 15).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -15).isActive = true
        
    }
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
