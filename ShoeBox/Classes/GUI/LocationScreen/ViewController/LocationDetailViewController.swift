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
    private let regionDistance: CLLocationDistance = 100

    var location: Location?
    
    var directions: String?
    var details = [String]()
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = location?.title
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        centerMapOnLocation()
        
        if let currentLocation = LocationManager.sharedInstance.currentLocation, let placeLatitude = self.location!.latitude, let placeLongitude = self.location!.longitude {
            let place = CLLocation(latitude: placeLatitude, longitude: placeLongitude)
            let distance = currentLocation.distance(from: place)
            directions = NSLocalizedString("shoebox_distance", comment: "") + ": " + String(roundToPlaces(value: distance / 1000, places: 1)) + " KM"
        } else {
            directions = NSLocalizedString("shoebox_distance", comment: "") + ": " + NSLocalizedString("shoebox_calculating", comment: "")
        }
       
        details.append((location?.addressFull)!)
        if let location = location {
            if let hours = location.hours, hours.characters.count > 0 {
                details.append(hours)
            }
            if let locContacts = location.contacts, locContacts.count > 0 {
                for contact in locContacts {
                    contacts.append(contact)
                }
            }
            if let messages = location.messages, messages.characters.count > 0 {
                details.append(messages)
            }
        }
    }
    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    
    //MARK: UItableViewDataSouce
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count + contacts.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = indexPath.row > details.count ? "contact" : "cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        }
        configureCell(cell!, atIndexPath: indexPath)
        
        return cell!
    }

    //MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            openMapFor(location!)
        } else if indexPath.row > details.count {
            callNumber((contacts[indexPath.row - (details.count + 1)].phoneNumber))
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //MARK: Helper methods
    
    fileprivate func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        var title: String?
        var subtitle: String?
        let row = indexPath.row
        
        if (row == 0) {
            title = directions
            cell.textLabel?.isEnabled = true
            cell.imageView?.image = UIImage(glyphNamed: "directions")
            cell.accessoryType = .disclosureIndicator
        } else if (row > details.count) {
            let contact = contacts[row - (details.count + 1)]
            title = contact.name
            subtitle = contact.phoneNumber
            cell.textLabel?.isEnabled = true
            cell.imageView?.image = UIImage(glyphNamed: "call")
        } else if (row <= details.count) {
            let current = row - 1
            title = self.details[current]
            cell.textLabel?.isEnabled = false
            var imageName: String
            switch current {
            case 0:
                imageName = "address"
            case 1:
                imageName = "hours"
            default:
                imageName = ""
            }
            cell.imageView?.image = UIImage(glyphNamed: imageName)
        }
        
        cell.textLabel?.text = title
        cell.textLabel?.numberOfLines = 0;
        cell.detailTextLabel?.text = subtitle
    }
    
    
    fileprivate func openMapFor(_ location: Location) {
        let latitute:CLLocationDegrees =  location.latitude!
        let longitute:CLLocationDegrees =  location.longitude!
        
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.title
        mapItem.openInMaps(launchOptions: options)
    }
    
    fileprivate func callNumber(_ phoneNumber:String) {
        if let phoneCallURL:URL = URL(string: "tel://\(phoneNumber.removeWhitespace())") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    
    fileprivate func centerMapOnLocation() {
        if let location = location, let latitude = location.latitude, let longitude = location.longitude {
            let newCoordinate = CLLocationCoordinate2DMake(latitude, longitude)

            let coordinateRegion = MKCoordinateRegionMakeWithDistance(newCoordinate,
                                               regionDistance * 2.0, regionDistance * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
            
            let spot = Spot(location: location)
            mapView.addAnnotation(spot)
        }
    }
}


extension LocationDetailViewController {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Spot {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            view.pinTintColor = UIColor.shoeBoxBlueColor(0.9)

            return view
        }
        return nil
    }
}

