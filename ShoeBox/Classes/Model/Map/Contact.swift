//
//  Contact.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/3/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

class Contact {

    var name: String?
    var phoneNumber: String?
    
    init(dict: NSDictionary) {
        name = dict.objectForKey("name") as? String
        phoneNumber = dict.objectForKey("phoneNumber") as? String
    }
}
