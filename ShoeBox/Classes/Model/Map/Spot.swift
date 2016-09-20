//
//  Spot.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/2/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import GoogleMaps

class Spot: NSObject, GMUClusterItem {
    
    var marker: GMSMarker
    var position: CLLocationCoordinate2D
    
    init(marker: GMSMarker) {
        self.marker = marker
        self.position = marker.position
    }
}
