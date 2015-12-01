//
//  LocalizedNavigationItem.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/1/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class LocalizedNavigationItem: UINavigationItem {
    
    var localizedText: String! {
        didSet {
            self.title = NSLocalizedString(localizedText, comment: "")
        }
    }
}
