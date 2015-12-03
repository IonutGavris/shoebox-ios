//
//  Location.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 29/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

class Location {
    
    var address:String?
    var addressFull:String?
    var city:String?
    var contacts:[Contact]?
    var country:String?
    var hours:String?
    var latitude:Double?
    var longitude:Double?
    var state:String?
    var title:String?
    
    init(dict : NSDictionary) {
        address = dict.objectForKey("address") as? String
        addressFull = dict.objectForKey("addressFull") as? String
        city = dict.objectForKey("city") as? String
        let data = dict.objectForKey("contacts") as? NSArray
        if (data != nil) {
            contacts = [Contact]()
            for contactDict in data! {
                let contact = Contact(dict: (contactDict as? NSDictionary)!)
                contacts!.append(contact)
            }
        }
        country = dict.objectForKey("country") as? String
        hours = dict.objectForKey("hours") as? String
        latitude = Double.init(dict.objectForKey("latitude") as! NSNumber)
        longitude = Double.init(dict.objectForKey("longitude") as! NSNumber)
        state = dict.objectForKey("state") as? String
        title = dict.objectForKey("title") as? String
    }
}