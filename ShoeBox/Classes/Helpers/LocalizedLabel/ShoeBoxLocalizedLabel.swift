//
//  ShoeBoxLocalizedLabel.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 29/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class ShoeBoxLocalizedLabel: UILabel {

    var localizedText: String! {
        didSet {
            self.text = NSLocalizedString(localizedText, comment: "")
        }
    }
}
