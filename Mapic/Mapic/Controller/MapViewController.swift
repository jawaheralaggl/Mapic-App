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
    
    let userLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainColor
        button.setImage(UIImage(systemName: "location.north"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 60 / 2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(userLocationTapped), for: .touchUpInside)
        return button
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Standard", "Satellite", "Hybrid"])
        segmented.selectedSegmentIndex = 0
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.addTarget(self, action: #selector(changeType(_:)), for: .valueChanged)
        return segmented
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .mainColor
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(userLocationButton)
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
    
    // center the map on user location and change the button image
    @objc func userLocationTapped() {
        zoomInUserLocation()
        userLocationButton.setImage(UIImage(systemName: "location.north.fill"), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
            // set back original image
            self.userLocationButton.setImage(UIImage(systemName: "location.north"), for: .normal)
        }
    }
    
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
        
        collectionView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        
        userLocationButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        userLocationButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        userLocationButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -5).isActive = true
        userLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        
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

// MARK: - UICollectionViewDelegateFlowLayout\DataSource

extension MapViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3.5)
    }
}

extension MapViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picCell", for: indexPath)
        return cell
    }
    
}
