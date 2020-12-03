//
//  MapViewController.swift
//  Mapic
//
//  Created by Jawaher Alagel on 11/30/20.
//

import UIKit
import MapKit

struct PicturesData {
    var distance: String
    var image: UIImage
}

class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    var manager = CLLocationManager() 
    let authorizationStatus = CLLocationManager.authorizationStatus() //TODO: find replacement
    var pinCoordinate: CLLocationCoordinate2D!
    
    let userLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainColor
        button.setImage(UIImage(systemName: "location.north"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 50 / 2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(userLocationTapped), for: .touchUpInside)
        return button
    }()
    
    let mapTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainColor
        button.setImage(UIImage(systemName: "map"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 50 / 2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(typeTapped), for: .touchUpInside)
        return button
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(PicturesCell.self, forCellWithReuseIdentifier: "picCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // set array of data from the struct properties
    let data = [
        PicturesData(distance: "1 km", image: #imageLiteral(resourceName: "3")),
        PicturesData(distance: "1.5 km", image: #imageLiteral(resourceName: "4")),
        PicturesData(distance: "1.75 km", image: #imageLiteral(resourceName: "1")),
        PicturesData(distance: "2.5 km", image: #imageLiteral(resourceName: "2")),
        PicturesData(distance: "2.75 km", image: #imageLiteral(resourceName: "3")),
        PicturesData(distance: "3.0 km", image: #imageLiteral(resourceName: "4")),
        PicturesData(distance: "3.5 km", image: #imageLiteral(resourceName: "1"))
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(mapTypeButton)
        view.addSubview(userLocationButton)
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
    
    // MARK: - Selectors
    
    // toggle map type when button is selected
    var isChecked = false
    @objc func typeTapped() {
        isChecked = !isChecked
        if isChecked {
            mapView.mapType = .satellite
        } else {
            mapView.mapType = .standard
        }
    }
    
    // center the map on user location and change the button image
    @objc func userLocationTapped() {
        zoomInUserLocation()
        userLocationButton.setImage(UIImage(systemName: "location.north.fill"), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
            // set back original image
            self.userLocationButton.setImage(UIImage(systemName: "location.north"), for: .normal)
        }
    }
    
    // MARK: - Helpers
    
    func configurUI() {
        let margin = view.layoutMarginsGuide
        
        collectionView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -190).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        
        userLocationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userLocationButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userLocationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        userLocationButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -0).isActive = true
        
        mapTypeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mapTypeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mapTypeButton.topAnchor.constraint(equalTo: userLocationButton.bottomAnchor, constant: 8).isActive = true
        mapTypeButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -0).isActive = true
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // return nil to display the default system view (blue beacon)
        if annotation is MKUserLocation {
            return nil
        }
        
        // create custom view (pin)
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "locationPin")
        pinAnnotation.pinTintColor = .mainColor
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
    // set the region to center the map on user location
    func zoomInUserLocation() {
        guard let coordinate = manager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000 , longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        collectionView.reloadData()
        
        // drop pin on user location
        let pinAnnotation = Pin(identifier: "locationPin", coordinate: coordinate)
        mapView.addAnnotation(pinAnnotation)
        
        FlickrService.shared.fetchUrls(forAnnotation: pinAnnotation) { (checked) in
            if checked {
                FlickrService.shared.fetchImages { (checked) in
                    if checked {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
                
            }
        }
        
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
        return FlickrService.shared.pictureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picCell", for: indexPath) as! PicturesCell
        let picOfIndex = FlickrService.shared.pictureArray[indexPath.row]
        cell.imageView.image = picOfIndex
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PictureInfoViewController") as! PictureInfoViewController
        controller.data = self.data[indexPath.row] // pass selected cell data to next view
        present(controller, animated: true)
    }
    
}
