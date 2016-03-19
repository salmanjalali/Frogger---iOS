//
//  MapViewController.swift
//  WearHacks
//
//  Created by Salman Jalali on 2016-03-18.
//  Copyright © 2016 Salman Jalali. All rights reserved.
//

import Foundation
import Mapbox
import UIKit
import CoreLocation

class MapViewController: UIViewController, MGLMapViewDelegate, CLLocationManagerDelegate {
    //MARK: Properties
    var lat: Float = 0
    var long: Float = 0
    var name: String = "Current Location"
    var location: String = "You are currently at this location.."
    let locationManager = CLLocationManager()
    
    @IBOutlet var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: Double(self.lat), longitude: Double(self.long))
        point.title = self.name
        point.subtitle = self.location
        
        let locManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
        }
        
        mapView.addAnnotation(point)
        mapView.showsUserLocation = true
        mapView.zoomLevel = 14
        print("Location: \(mapView.userLocation)")
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
