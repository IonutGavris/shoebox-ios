//
//  PageView.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 19/11/2016.
//  Copyright © 2016 ShoeBox. All rights reserved.
//

import UIKit

class PageView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewDetails: (text: String, pageIndex: Int, imageNamed: String)! {
        didSet {
            descriptionLabel.text = viewDetails.text
            descriptionLabel.accessibilityIdentifier = String(viewDetails.pageIndex)
            imageView.image = UIImage(named: viewDetails.imageNamed)
        }
    }
}
