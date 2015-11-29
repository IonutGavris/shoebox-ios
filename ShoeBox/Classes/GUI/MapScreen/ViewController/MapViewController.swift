//
//  MapViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import GoogleMaps
import UIKit

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    // segue id
    let suggestionSegueIdentifier = "ShowLocationDetailsScreenIdentifier"
    
    // Get a reference to firebase locations endpoint
    let locations = Firebase(url: "https://shoebox.firebaseio.com/locations")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initGoogleMaps();
    }
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.cameraWithLatitude(45.9321727,longitude: 24.9330333, zoom: 6)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        mapView.delegate = self
        self.view = mapView
        
        // Attach a closure to read the data from firebase
        locations.observeEventType(.Value, withBlock: { snapshot in
            guard let locations = snapshot.value as? NSArray else {
                return
            }
            var current:Location
            var marker:GMSMarker
            for location in locations {
                current = Location(dict: location as! NSDictionary)
                marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake(current.latitude!, current.longitude!)
                marker.title = current.title;
                marker.snippet = current.city;
                marker.userData = current;
                marker.icon = GMSMarker.markerImageWithColor(UIColor.shoeBoxBlueColor(1.0))
                marker.opacity = 0.9
                marker.map = mapView
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        //var infoWindow = NSBundle.mainBundle().loadNibNamed("CustomInfoWindow", owner: self, options: nil).first! as CustomInfoWindow
        //infoWindow.label.text = "\(marker.position.latitude) \(marker.position.longitude)"
        self.performSegueWithIdentifier(self.suggestionSegueIdentifier, sender: self)
        return nil
    }
    
    func getDistanceMetresBetweenLocationCoordinates(coord1: CLLocationCoordinate2D, coord2: CLLocationCoordinate2D) -> Double {
        let location1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
        let location2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
        return location1.distanceFromLocation(location2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

