//
//  MapViewController.swift
//  Map-swift
//
//  Created by Gazolla on 25/07/14.
//  Copyright (c) 2014 Gazolla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController{
    
    lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.mapType = .standard
        mv.showsCompass = false
        mv.showsScale = false
        mv.isZoomEnabled = true
        mv.isScrollEnabled = true
        mv.showsUserLocation = true
        
        let scale = MKScaleView(mapView: mv)
        scale.translatesAutoresizingMaskIntoConstraints = false
        scale.scaleVisibility = .visible
        
        mv.addSubview(scale)
        
        let compass = MKCompassButton(mapView: mv)
        compass.translatesAutoresizingMaskIntoConstraints = false
        compass.compassVisibility = .visible
        
        mv.addSubview(compass)
        
        let guide = mv.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [
                scale.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 16.0),
                scale.rightAnchor.constraint(equalTo: guide.centerXAnchor),
                scale.topAnchor.constraint(equalTo: guide.topAnchor),
                scale.heightAnchor.constraint(equalToConstant: 20.0),
                compass.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -12.0),
                compass.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -12.0)
            ]
        )
        
        return mv
    }()
    
    let locationManager:CLLocationManager = {
        let lm = CLLocationManager()
        return lm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    override func viewWillLayoutSubviews() {
        let margins = view.safeAreaLayoutGuide
        mapView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: margins.heightAnchor).isActive = true
    }
}

extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
