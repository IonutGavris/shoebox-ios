//
//  LocationManager.swift
//  ShoeBox
//
//  Created by Madalina Miron on 28/11/16.
//  Copyright © 2016 ShoeBox. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func locationReceived(currentLocation: CLLocation)
    func locationDidFailWithError(error: NSError)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationManager()
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        self.currentLocation = location
        updateLocation(currentLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateLocationDidFailWithError(error: error as NSError)
    }
    
    private func updateLocation(currentLocation: CLLocation) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.locationReceived(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.locationDidFailWithError(error: error)
    }
}
