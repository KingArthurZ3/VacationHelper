//
//  ViewController.swift
//  VacationHelper
//
//  Created by Arthur Zhang on 5/26/17.
//  Copyright © 2017 Arthur Zhang. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        var currentLocation = CLLocation()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            
            currentLocation = locManager.location!
            
        }

        
        GMSServices.provideAPIKey("AIzaSyAQO7HACrSmKRyFX8Bo_5CJQxH0Xf9M4ss")
        GMSPlacesClient.provideAPIKey("AIzaSyAQO7HACrSmKRyFX8Bo_5CJQxH0Xf9M4ss")
        
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 12)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        view = mapView
        
        let currentLocationAddress = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        
        let marker = GMSMarker(position: currentLocationAddress)
        marker.title = "Current Location"
        marker.snippet = "You are here"
        marker.map = mapView

       
        
        // sfo airport lat: 37.621317 long: -122.379158
        
//        let currentLocation = CLLocationCoordinate2DMake(37.62131737, -122.379158)
//        
//        let marker = GMSMarker(position: currentLocation)
//        marker.title = "SFO Airport"
//        marker.map = mapView

        
        
    }
 
    

}

