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
    func locationDidFailWithError(error: Error)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationManager()
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        
        self.locationManager?.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.locationManager?.startUpdatingLocation()
        } else {
            self.locationManager?.requestWhenInUseAuthorization()
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
        updateLocationDidFailWithError(error: error)
    }
    
    private func updateLocation(currentLocation: CLLocation) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.locationReceived(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: Error) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.locationDidFailWithError(error: error)
    }
}
