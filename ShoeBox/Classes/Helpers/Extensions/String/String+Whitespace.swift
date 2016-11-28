//
//  String+Whitespace.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/4/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

extension String {
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    
    func firstCharacterUppercased() -> String {
        let str = self as NSString
        let firstUppercaseCharacter = str.substring(to: 1).uppercased()
        let firstUppercaseCharacterString = str.replacingCharacters(in: NSMakeRange(0, 1), with: firstUppercaseCharacter)
        return firstUppercaseCharacterString
    }
    
    func stringBeforeCharacter(_ character: String) -> String {
        let string = self as NSString
        let range = string.range(of: character)
        
        return string.substring(to: range.location) as String
    }
    
    func stringWithoutDot() -> String {
        var string = self as NSString
        
        let allCharacters = string.components(separatedBy: " ")
        let lastCharacter = self.characters.last!
        
        if lastCharacter == "." && allCharacters.count < 3 {
            string = string.replacingOccurrences(of: ".", with: "") as NSString
        }
        return string as String
    }
}
