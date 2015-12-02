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
    
    var mapView: GMSMapView!
    var clusterManager: GClusterManager!
    var firstLocationUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addGoogleMaps();
    }
    
    override func viewWillAppear(animated: Bool) {
        mapView.myLocationEnabled = true
        mapView.addObserver(self, forKeyPath: "myLocation", options: .New, context: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        mapView.myLocationEnabled = false
        mapView.removeObserver(self, forKeyPath: "myLocation")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == suggestionSegueIdentifier
        {
            if let destination = segue.destinationViewController as? LocationDetailViewController{
                destination.location = sender as? Location
            }
        }
    }
    
    //MARK: Google Maps
    
    func addGoogleMaps() {
        let camera = GMSCameraPosition.cameraWithLatitude(45.9321727,longitude: 24.9330333, zoom: 6)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self;
        self.view = mapView
        
        // Create the Cluster Manager
        self.clusterManager = GClusterManager(mapView: mapView, algorithm: NonHierarchicalDistanceBasedAlgorithm(), renderer: GDefaultClusterRenderer(mapView: mapView))
        
        // Get a reference to firebase locations endpoint
        let ref = Firebase(url: Constants.ENDPOINT_LOCATIONS)
        // Attach a closure to read the data from firebase
        ref.observeEventType(.Value, withBlock: { snapshot in
            guard let locations = snapshot.value as? NSArray else {
                return
            }
            var current:Location
            var marker:GMSMarker
            self.clusterManager.removeItems()
            for location in locations {
                current = Location(dict: location as! NSDictionary)
                marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake(current.latitude!, current.longitude!)
                marker.title = current.title;
                marker.snippet = current.city;
                marker.userData = current;
                marker.icon = GMSMarker.markerImageWithColor(UIColor.shoeBoxBlueColor(1.0))
                marker.opacity = 0.9
                self.clusterManager.addItem(Spot(marker: marker))
            }
            self.clusterManager.cluster()
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    func getDistanceMetresBetweenLocationCoordinates(coord1: CLLocationCoordinate2D, coord2: CLLocationCoordinate2D) -> Double {
        let location1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
        let location2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
        return location1.distanceFromLocation(location2)
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
                self.mapView.camera = GMSCameraPosition.cameraWithTarget((location?.coordinate)!, zoom: 6)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue(), {
                    self.mapView.animateToZoom(12)
                })
            }
        }
    }
    
    //MARK: GMSMapViewDelegate
    
    func mapView(mapView: GMSMapView!, markerInfoContents marker: GMSMarker!) -> UIView! {
        let infoWindow = NSBundle.mainBundle().loadNibNamed("CustomInfoWindow", owner: self, options: nil).first! as! CustomInfoWindow
        let selectedLocation = marker.userData as? Location
        infoWindow.title.text = selectedLocation?.title
        infoWindow.subtitle.text = selectedLocation?.city
        return infoWindow
    }
    
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        clusterManager.mapView(mapView, idleAtCameraPosition: position)
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        self.performSegueWithIdentifier(self.suggestionSegueIdentifier, sender: marker.userData as? Location)
    }
}

