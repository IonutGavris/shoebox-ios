//
//  MapViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import GoogleMaps
import UIKit

class MapViewController: UIViewController {
    
    // Get a reference to firebase locations endpoint
    var locations = Firebase(url: "https://shoebox.firebaseio.com/locations")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Attach a closure to read the data from firebase
        locations.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        loadGoogleMaps()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGoogleMaps() {
        let camera = GMSCameraPosition.cameraWithLatitude(46.7695945,longitude: 23.5862859, zoom: 12)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(46.7695945, 23.5862859)
        marker.title = "Cluj-Napoca"
        marker.snippet = "Romania"
        marker.map = mapView
    }
}

