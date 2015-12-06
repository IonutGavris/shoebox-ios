//
//  LocationDetailViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import GoogleMaps
import MapKit
import UIKit

class LocationDetailViewController: UITableViewController, GMSMapViewDelegate {
    
    var mapView: GMSMapView!
    var location: Location?
    var firstLocationUpdate = false
    
    var directions: String?
    var details = [String]()
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = location?.title
        initGoogleMaps(location!)
        
        directions = NSLocalizedString("shoebox_distance", comment: "") + ": " + NSLocalizedString("shoebox_calculating", comment: "")
        details.append((location?.addressFull)!)
        details.append((location?.hours)!)
        if location?.contacts?.count > 0 {
            for contact in (location?.contacts)! {
                contacts.append(contact)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        mapView.myLocationEnabled = true
        mapView.addObserver(self, forKeyPath: "myLocation", options: .New, context: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        mapView.myLocationEnabled = false
        mapView.removeObserver(self, forKeyPath: "myLocation")
    }
    
    func initGoogleMaps(location: Location) {
        let camera = GMSCameraPosition.cameraWithLatitude(location.latitude!,longitude: location.longitude!, zoom: 16)
        let rect = tableView.tableHeaderView!.frame
        mapView = GMSMapView.mapWithFrame(rect, camera: camera)
        mapView.delegate = self
        mapView.mapType = GoogleMaps.kGMSTypeHybrid
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(location.latitude!, location.longitude!)
        marker.icon = GMSMarker.markerImageWithColor(UIColor.shoeBoxBlueColor(1.0))
        marker.opacity = 0.9
        marker.map = mapView
        tableView.tableHeaderView = mapView
    }
    
    func initPanorama(location: Location) {
        let panoView = GMSPanoramaView(frame: tableView.tableHeaderView!.frame)
        tableView.tableHeaderView = panoView
        panoView.moveNearCoordinate(CLLocationCoordinate2DMake((location.latitude)!, (location.longitude)!))
    }
    
    func getDistanceMetresBetweenLocationCoordinates(coord1: CLLocationCoordinate2D, coord2: CLLocationCoordinate2D) -> Double {
        let location1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
        let location2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
        return location1.distanceFromLocation(location2)
    }
    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    
    //MARK: UItableViewDataSouce
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count + contacts.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = indexPath.row > details.count ? "contact" : "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
        }
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        var title: String?
        var subtitle: String?
        let row = indexPath.row
        
        if (row == 0) {
            title = directions
            cell.textLabel?.enabled = true
            cell.accessoryType = .DisclosureIndicator
        } else if (row > details.count) {
            let contact = contacts[row - 3]
            title = contact.name
            subtitle = contact.phoneNumber
            cell.textLabel?.enabled = true
        } else {
            title = self.details[row - 1]
            cell.textLabel?.enabled = false
        }
        
        cell.textLabel?.text = title
        cell.textLabel?.numberOfLines = 0;
        cell.detailTextLabel?.text = subtitle
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            openMapForPlace(location!)
        } else if indexPath.row > details.count {
            callNumber((contacts[indexPath.row - 3].phoneNumber)!)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    private func openMapForPlace(location: Location) {
        let latitute:CLLocationDegrees =  location.latitude!
        let longitute:CLLocationDegrees =  location.longitude!
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.title
        mapItem.openInMapsWithLaunchOptions(options)
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber.removeWhitespace())") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    
    //MARK: MapViewDelegate
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (context != nil) {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
        if (!firstLocationUpdate) {
            // If the first location update has not yet been recieved, then jump to that
            // location.
            firstLocationUpdate = true;
            let start = CLLocation(latitude: self.location!.latitude!, longitude: self.location!.longitude!)
            let destination = change?[NSKeyValueChangeNewKey] as? CLLocation
            let distance = getDistanceMetresBetweenLocationCoordinates(start.coordinate, coord2: destination!.coordinate)
            directions = NSLocalizedString("shoebox_distance", comment: "") + ": " + String(roundToPlaces(distance / 1000, places: 1)) + " KM"
            self.tableView.reloadData()
        }
    }
}
