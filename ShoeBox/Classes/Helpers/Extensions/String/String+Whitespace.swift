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
    
    func firstCharacterUppercased() -> String {
        let str = self as NSString
        let firstUppercaseCharacter = str.substringToIndex(1).uppercaseString
        let firstUppercaseCharacterString = str.stringByReplacingCharactersInRange(NSMakeRange(0, 1), withString: firstUppercaseCharacter)
        return firstUppercaseCharacterString
    }
    
    func stringBeforeCharacter(character: String) -> String {
        let string = self as NSString
        let range = string.rangeOfString(character)
        
        return string.substringToIndex(range.location) as String
    }
    
    func stringWithoutDot() -> String {
        var string = self as NSString
        
        let allCharacters = string.componentsSeparatedByString(" ")
        let lastCharacter = self.characters.last!
        
        if lastCharacter == "." && allCharacters.count < 3 {
            string = string.stringByReplacingOccurrencesOfString(".", withString: "")
        }
        return string as String
    }
}
