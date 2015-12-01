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
    let suggestionSegueIdentifier = "ShowMapLocationDetailsScreenIdentifier"
    
    // Get a reference to firebase locations endpoint
    let ref = Firebase(url: "https://shoebox.firebaseio.com/locations")
    
    var selectedLocation: Location?
    var mapView: GMSMapView!
    var firstLocationUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initGoogleMaps();
    }
    
    override func viewWillAppear(animated: Bool) {
        mapView.myLocationEnabled = true
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        mapView.myLocationEnabled = false
        mapView.removeObserver(self, forKeyPath: "myLocation")
    }
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.cameraWithLatitude(45.9321727,longitude: 24.9330333, zoom: 6)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        self.view = mapView
        
        // Attach a closure to read the data from firebase
        ref.observeEventType(.Value, withBlock: { snapshot in
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
                marker.map = self.mapView
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (context != nil) {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
        if (!firstLocationUpdate) {
            // If the first location update has not yet been recieved, then jump to that
            // location.
            firstLocationUpdate = true;
            let location = change?[NSKeyValueChangeNewKey] as? CLLocation
            if (location != nil) {
                mapView.camera = GMSCameraPosition.cameraWithTarget((location?.coordinate)!, zoom: 12);
            }
        }
    }
    
    func mapView(mapView: GMSMapView!, markerInfoContents marker: GMSMarker!) -> UIView! {
        let infoWindow = NSBundle.mainBundle().loadNibNamed("CustomInfoWindow", owner: self, options: nil).first! as! CustomInfoWindow
        selectedLocation = marker.userData as? Location
        infoWindow.title.text = selectedLocation?.title
        infoWindow.subtitle.text = selectedLocation?.city
        return infoWindow
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        self.performSegueWithIdentifier(self.suggestionSegueIdentifier, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == suggestionSegueIdentifier
        {
            if let destination = segue.destinationViewController as? LocationDetailViewController{
                destination.location = selectedLocation
            }
        }
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

