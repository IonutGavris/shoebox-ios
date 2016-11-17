//
//  MapViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private struct MapViewConstants {
        // segue id
        static let suggestionSegueIdentifier = "ShowMapLocationDetailsScreenIdentifier"
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    var firstLocationUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupMapView()
        
        
        // Get a reference to firebase locations endpoint
        let ref = Firebase(url: Constants.ENDPOINT_LOCATIONS)
        // Attach a closure to read the data from firebase
        ref.observeEventType(.Value, withBlock: { snapshot in
            guard let locations = snapshot.value as? NSArray else {
                return
            }
            var current: Location
            var spots = [Spot]()
            for location in locations {
                current = Location(dictionary: location as! [String : AnyObject])
                let spot = Spot(location: current)
                spots.append(spot)
            }
            self.mapView.addAnnotations(spots)
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == MapViewConstants.suggestionSegueIdentifier {
            if let destination = segue.destinationViewController as? LocationDetailViewController{
                destination.location = sender as? Location
            }
        }
    }

    //MARK: Helper methods
    
    private func setupMapView() {
        // set initial location in Cluj Napoca
        let latitude = 46.769439;
        let longitude = 23.590007;
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        centerMapOnLocationFrom(initialLocation.coordinate)
    }
    
    func centerMapOnLocationFrom(coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

extension MapViewController {
    
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
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        centerMapOnLocationFrom(userLocation.coordinate)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let spot = view.annotation as! Spot
        performSegueWithIdentifier(MapViewConstants.suggestionSegueIdentifier, sender:spot.location)
    }
}
