//
//  MapViewController.swift
//  Map-swift
//
//  Created by Gazolla on 25/07/14.
//  Copyright (c) 2014 Gazolla. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    
    var map:MKMapView?
    
    convenience init(frame:CGRect){
        self.init(nibName: nil, bundle: nil)
        self.view.frame = frame
        self.title = "Maps on Swift"

        self.map = MKMapView(frame: frame)
        self.map!.delegate = self
        
        self.view.addSubview(self.map)
        

       adjustRegion(37.3175,aLongitude: -122.0419)
       addPoint("Whole Foods Market", aCategory: "Grocery Store", aLatitude: 37.323551, aLongitude: -122.039653)
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
    
    func addPoint(aName:String, aCategory:String,aLatitude:CLLocationDegrees, aLongitude: CLLocationDegrees){
        var point:MKPointAnnotation = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2DMake(aLatitude,aLongitude);
        point.title = aName
        point.subtitle = aCategory
        
        map!.addAnnotation(point)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            
            if annotation is MKUserLocation {
                //return nil so map view draws "blue dot" for standard user location
                return nil
            }
            
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.animatesDrop = true
                pinView!.pinColor = .Purple
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
    }
    
}
