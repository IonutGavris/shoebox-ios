//
//  LocalizedBarButtonItem.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/1/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class LocalizedBarButtonItem: UIBarButtonItem {
    
    var localizedText: String! {
        didSet {
            self.title = NSLocalizedString(localizedText, comment: "")
        }
    }
    
    var barButtonTitle: String! {
        didSet {
            
            let font = UIFont.icommonFont(size: 20.0)
            let attributes = [NSFontAttributeName : font,
                NSForegroundColorAttributeName : UIColor.white]
            
            self.title = barButtonTitle
            self.setTitleTextAttributes(attributes, for: UIControlState())
        }
    }
}
