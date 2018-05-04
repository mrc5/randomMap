//
//  ViewController.swift
//  randomMap
//
//  Created by Marcus on 03.05.18.
//  Copyright © 2018 Marcus Hopp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    var mapView: MKMapView!
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "randomMap"
        setupMap()
        setupLocationManager()
    }
    
    private func setupMap() {
        mapView = MKMapView(frame: .zero)
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.delegate = self
        
        checkForLocationAuthorization()
    }
    
    private func checkForLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }
        } else {
            
        }
    }
    
    private func setupAuthorizationView() {
        
    }

}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    
}

