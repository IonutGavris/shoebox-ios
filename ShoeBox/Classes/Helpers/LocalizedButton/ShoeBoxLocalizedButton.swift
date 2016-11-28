//
//  ShoeBoxLocalizedButton.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 29/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class ShoeBoxLocalizedButton: UIButton {
    
    var localizedText: String! {
        didSet {
            let newText = NSLocalizedString(localizedText, comment: "")
            self.setTitle(newText, for: UIControlState())
        }
    }

}
