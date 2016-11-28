//
//  Location.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 29/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

struct Location: BaseModelProtocol {
    
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
    
    init(dictionary : [String: AnyObject]) {
        address = dictionary["address"] as? String
        addressFull = dictionary["addressFull"] as? String
        city = dictionary["city"] as? String
        if let data = dictionary["contacts"] as? NSArray {
            contacts = [Contact]()
            for contactDict in data {
                let contact = Contact(dictionary: contactDict as! [String : AnyObject])
                contacts!.append(contact)
            }
        }

        country = dictionary["country"] as? String
        hours = dictionary["hours"] as? String
        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        state = dictionary["state"] as? String
        title = dictionary["title"] as? String
    }
}
