//
//  LocationDetailViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import MapKit
import UIKit

class LocationDetailViewController: UITableViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var location: Location?
    var firstLocationUpdate = false
    
    var directions: String?
    var details = [String]()
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = location?.title
        centerMapOnLocation()
        directions = NSLocalizedString("shoebox_distance", comment: "") + ": " + NSLocalizedString("shoebox_calculating", comment: "")
        details.append((location?.addressFull)!)
        if (location?.hours?.characters.count > 0) {
            details.append((location?.hours)!)
        }
        if location?.contacts?.count > 0 {
            for contact in (location?.contacts)! {
                contacts.append(contact)
            }
        }
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
            cell.imageView?.image = UIImage(glyphNamed: "directions")
            cell.accessoryType = .DisclosureIndicator
        } else if (row > details.count) {
            let contact = contacts[row - (details.count + 1)]
            title = contact.name
            subtitle = contact.phoneNumber
            cell.textLabel?.enabled = true
            cell.imageView?.image = UIImage(glyphNamed: "call")
        } else {
            let current = row - 1
            title = self.details[current]
            cell.textLabel?.enabled = false
            cell.imageView?.image = UIImage(glyphNamed: current == 0 ? "address" : "hours")
        }
        
        cell.textLabel?.text = title
        cell.textLabel?.numberOfLines = 0;
        cell.detailTextLabel?.text = subtitle
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            openMapFor(location!)
        } else if indexPath.row > details.count {
            callNumber((contacts[indexPath.row - (details.count + 1)].phoneNumber))
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    //MARK: Helper methods
    
    private func openMapFor(location: Location) {
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
    
    private func centerMapOnLocation() {
        if let location = location, let latitude = location.latitude, let longitude = location.longitude {
            let newCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
            let regionRadius: CLLocationDistance = 1000

            let coordinateRegion = MKCoordinateRegionMakeWithDistance(newCoordinate,
                                               regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
            
            let spot = Spot(location: location)
            mapView.addAnnotation(spot)
        }
    }
}


extension LocationDetailViewController {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Spot {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                if #available(iOS 9.0, *) {
                    view.pinTintColor = UIColor.shoeBoxRedColor(0.9)
                } else {
                    // Fallback on earlier versions
                }
            }
            return view
        }
        return nil
    }
}

