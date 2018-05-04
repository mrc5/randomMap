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

enum AuthFailedReason {
    case noLocationServices
    case authDenied
}

class MapViewController: UIViewController {
    var mapView: MKMapView!
    var authorizationView: UIView!
    var authLabel: UILabel!
    var authButton: UIButton!
    
    var authFailedReason: AuthFailedReason!
    
    var locationManager: CLLocationManager!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        title = "randomMap"
        setupMap()
        setupAuthorizationView()
        setupLocationManager()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        authorizationView.translatesAutoresizingMaskIntoConstraints = false
        authorizationView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        authorizationView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
        authorizationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        authorizationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        authLabel.topAnchor.constraint(equalTo: authorizationView.topAnchor, constant: 20).isActive = true
        authLabel.leadingAnchor.constraint(equalTo: authorizationView.leadingAnchor, constant: 8).isActive = true
        authLabel.trailingAnchor.constraint(equalTo: authorizationView.trailingAnchor, constant: -8).isActive = true
        
        authButton.translatesAutoresizingMaskIntoConstraints = false
        authButton.topAnchor.constraint(equalTo: authLabel.bottomAnchor, constant: 24).isActive = true
        authButton.leadingAnchor.constraint(equalTo: authorizationView.leadingAnchor, constant: 8).isActive = true
        authButton.trailingAnchor.constraint(equalTo: authorizationView.trailingAnchor, constant: -8).isActive = true
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
                triggerAuthorizationView(.authDenied)
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }
        } else {
            triggerAuthorizationView(.noLocationServices)
        }
    }
    
    private func setupAuthorizationView() {
        authorizationView = UIView()
        authorizationView.alpha = 0
        authorizationView.layer.cornerRadius = 10
        mapView.addSubview(authorizationView)
        
        authLabel = UILabel()
        authLabel.text = "AUTH_FAILED_REASON"
        authLabel.numberOfLines = 0
        authorizationView.addSubview(authLabel)
        
        authButton = UIButton()
        authButton.setTitle("AUTH_BUTTON", for: .normal)
        authButton.layer.cornerRadius = 10
        authorizationView.addSubview(authButton)
    }

    private func triggerAuthorizationView(_ authFailedReason: AuthFailedReason) {
        UIView.animate(withDuration: 0.5) {
            self.authorizationView.alpha = 1
        }
        self.authFailedReason = authFailedReason
        
        switch authFailedReason {
        case .authDenied:
            authLabel.text = "Ortungsdienste wurden abgeschaltet. Um Stores orten zu können bitte einschalten"
            authButton.setTitle("Ortungsdienste aktivieren", for: .normal)
            authButton.addTarget(self, action: #selector(authDeniedAction), for: .touchUpInside)
        case .noLocationServices:
            authLabel.text = "Sie haben die Nutzung der Ortungsdienste durch randomMap deaktiviert. Bitte aktivieren um Funktion zu nutzen"
            authButton.setTitle("randomMap Zugriff auf Standort geben", for: .normal)
            authButton.addTarget(self, action: #selector(noLocationServicesAction), for: .touchUpInside)
        }
    }
    
    @objc func authDeniedAction() {
        
    }
    @objc func noLocationServicesAction() {
        
    }
}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    
}

