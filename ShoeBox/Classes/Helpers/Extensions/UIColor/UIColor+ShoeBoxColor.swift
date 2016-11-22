//
//  UIColor+ShoeBoxColor.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 28/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import Foundation

extension UIColor {

    static func shoeBoxGreenColor(_ alpha: Float) -> UIColor {
        return UIColor(fullRed: 5.0, fullGreen: 206.0, fullBlue: 57.0, alpha: alpha)
    }
    
    static func shoeBoxRedColor(_ alpha: Float) -> UIColor {
        return UIColor(fullRed: 255.0, fullGreen: 85.0, fullBlue: 0.0, alpha: alpha)

    }
    static func shoeBoxBlueColor(_ alpha: Float) -> UIColor {
        return UIColor(fullRed: 13.0, fullGreen: 50.0, fullBlue: 204.0, alpha: alpha)
    }
    
    convenience init(fullRed: Float, fullGreen: Float, fullBlue: Float, alpha: Float) {
        let divider = 255.0 as Float
        let red = fullRed / divider
        let green = fullGreen / divider
        let blue = fullBlue / divider
        
        self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
}
