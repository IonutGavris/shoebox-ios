//
//  Suggestion.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 02/12/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

struct Suggestion {
    var description: String
    var maxAge: NSNumber
    var minAge: NSNumber
    var name: String
    var sex: String
    
    init(dictionary: [String: AnyObject]) {
        description = dictionary["description"] as! String
        maxAge = dictionary["maxAge"] as! NSNumber
        minAge = dictionary["minAge"] as! NSNumber
        name = dictionary["name"] as! String
        sex = dictionary["sex"] as! String
    }
}
