//
//  Contact.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/3/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

struct Contact: BaseModelProtocol {

    let name: String
    let phoneNumber: String
    
    init(dictionary: [String: AnyObject]) {
        name = dictionary["name"] as! String
        phoneNumber = dictionary["phoneNumber"] as! String
    }
}
