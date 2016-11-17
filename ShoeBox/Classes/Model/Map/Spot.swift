//
//  Spot.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/2/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import MapKit

class Spot: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return newCoordinate
    }
    
    var title: String? {
        return location.title ?? ""
    }
    
    var subtitle: String? {
        return location.addressFull ?? ""
    }
    
    let location: Location
    let newCoordinate: CLLocationCoordinate2D
    init(location: Location) {
        self.location = location
        
        if let latitude = location.latitude, let longitude = location.longitude {
            self.newCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
        } else {
            //Cluj-Napoca
            let lat = NSNumber(double: 37.0902)
            let long = NSNumber(double: 95.7129)
            
            self.newCoordinate = CLLocationCoordinate2DMake(lat.doubleValue, long.doubleValue)
        }
    }
}
