//
//  ShoeBoxAgexTopView.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 28/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class ShoeBoxAgexTopView: UIView {

    @IBOutlet weak var girlBackgroundView: UIView!
    @IBOutlet weak var girlCheckmarkImageView: UIView!
    @IBOutlet weak var boyBackgroundView: UIView!
    @IBOutlet weak var boyCheckmarkImageView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    @IBAction func girlViewTapped(gesture: UITapGestureRecognizer) {
        girlCheckmarkImageView.alpha = 1.0
        boyCheckmarkImageView.alpha = 0.0
    }
    
    @IBAction func boyViewTapped(gesture: UITapGestureRecognizer) {
        girlCheckmarkImageView.alpha = 0.0
        boyCheckmarkImageView.alpha = 1.0

    }
}
