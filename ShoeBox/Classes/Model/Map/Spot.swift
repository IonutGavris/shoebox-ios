//
//  Spot.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/2/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import GoogleMaps

class Spot: NSObject, GMUClusterItem {
    
    let marker: GMSMarker
    let position: CLLocationCoordinate2D
    
    init(marker: GMSMarker) {
        self.marker = marker
        self.position = marker.position
    }
}
