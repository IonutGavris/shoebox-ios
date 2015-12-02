//
//  Location.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 29/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import Foundation

class Location {
    
    var address:String?
    var city:String?
    var country:String?
    var latitude:Double?
    var longitude:Double?
    var messages:String?
    var postalCode:String?
    var state:String?
    var title:String?
    
    init(dict : NSDictionary) {
        address = dict.objectForKey("address") as? String
        city = dict.objectForKey("city") as? String
        country = dict.objectForKey("country") as? String
        latitude = Double.init(dict.objectForKey("latitude") as! NSNumber)
        longitude = Double.init(dict.objectForKey("longitude") as! NSNumber)
        messages = dict.objectForKey("messages") as? String
        postalCode = dict.objectForKey("postalCode") as? String
        state = dict.objectForKey("state") as? String
        title = dict.objectForKey("title") as? String
    }
}