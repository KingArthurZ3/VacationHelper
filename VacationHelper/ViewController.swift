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

class VacationDestination: NSObject{
    
    let name: String?
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float){
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}

class ViewController: UIViewController {
    
    var mapView: GMSMapView?
    
    var currentDestination: VacationDestination?
    
    let destinations = [VacationDestination(name: "Embarcadero Station", location: CLLocationCoordinate2DMake(37.793126, -122.397059), zoom: 15),
                        VacationDestination(name: "Ferry Building", location: CLLocationCoordinate2DMake(37.795385, -122.393120), zoom: 18),
                        
                        
                        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GMSServices.provideAPIKey("AIzaSyAQO7HACrSmKRyFX8Bo_5CJQxH0Xf9M4ss")
        GMSPlacesClient.provideAPIKey("AIzaSyAQO7HACrSmKRyFX8Bo_5CJQxH0Xf9M4ss")
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.621442, longitude: -122.378888, zoom: 11)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(37.621442, -122.378888)
        
        let marker = GMSMarker(position: currentLocation)
        marker.title = "SFO Airport"
        marker.snippet = "Start here"
        marker.map = mapView
        
       
    }
    @IBAction func next(_ sender: UIBarButtonItem) {
        
        if(currentDestination == nil){
            currentDestination = destinations.first
        } else {
            if let index = destinations.index(of: currentDestination!) {
                currentDestination = destinations[index +  1]
            }
        }
        setMapCamera()
    }
 
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
        
    }
}

