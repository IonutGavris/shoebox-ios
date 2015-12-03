//
//  String+Whitespace.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/4/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
}
