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
    
    fileprivate struct MapViewConstants {
        // segue id
        static let suggestionSegueIdentifier = "ShowMapLocationDetailsScreenIdentifier"
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    var firstLocationUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupMapView()
        
        FirebaseManager.extractAllLocations { (locations) in
            var spots = [Spot]()
            for location in locations {
                let spot = Spot(location: location)
                spots.append(spot)
            }
            self.mapView.addAnnotations(spots)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MapViewConstants.suggestionSegueIdentifier {
            if let destination = segue.destination as? LocationDetailViewController{
                destination.location = sender as? Location
            }
        }
    }

    //MARK: Helper methods
    
    fileprivate func setupMapView() {
        // set initial location in Cluj Napoca
        let latitude = 46.769439;
        let longitude = 23.590007;
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        centerMapOnLocationFrom(initialLocation.coordinate)
    }
    
    func centerMapOnLocationFrom(_ coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

extension MapViewController {
    
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
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        centerMapOnLocationFrom(userLocation.coordinate)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let spot = view.annotation as! Spot
        performSegue(withIdentifier: MapViewConstants.suggestionSegueIdentifier, sender:spot.location)
    }
}
