//
//  MapViewController.swift
//  Map-swift
//
//  Created by Gazolla on 25/07/14.
//  Copyright (c) 2014 Gazolla. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var map:MKMapView?
    let locationManager:CLLocationManager = CLLocationManager()
    
    convenience init(frame:CGRect){
        self.init(nibName: nil, bundle: nil)
        self.view.frame = frame
        self.title = "Maps on Swift"

        self.map = MKMapView(frame: frame)
        self.map!.delegate = self
        //self.map!.showsUserLocation = true
        
        self.view.addSubview(self.map)
        

       adjustRegion(37.3175,aLongitude: -122.0419)
    }
    
    func adjustRegion(aLatitude:CLLocationDegrees, aLongitude: CLLocationDegrees){
        var latitude:CLLocationDegrees = aLatitude
        var longitude:CLLocationDegrees = aLongitude
        var latDelta:CLLocationDegrees = 0.5
        var longDelta:CLLocationDegrees = 0.5
        
        var aSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta,longitudeDelta: longDelta)
        var Center :CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(Center, aSpan)
        
        self.map!.setRegion(region, animated: true)
    }
    
    
    
}
