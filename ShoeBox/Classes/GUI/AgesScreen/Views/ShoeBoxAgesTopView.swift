//
//  ShoeBoxAgexTopView.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 28/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

typealias ShoeBoxAgesTopViewTapped = (String) -> Void

class ShoeBoxAgesTopView: UIView {

    @IBOutlet weak var girlBackgroundView: UIView!
    @IBOutlet weak var girlCheckmarkImageView: UIView!
    @IBOutlet weak var boyBackgroundView: UIView!
    @IBOutlet weak var boyCheckmarkImageView: UIView!
    
    var girlBoyTappedCompletion: ShoeBoxAgesTopViewTapped!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    @IBAction func girlViewTapped(_ gesture: UITapGestureRecognizer) {
        girlBackgroundView.backgroundColor = UIColor.shoeBoxRedColor(0.7)
        boyBackgroundView.backgroundColor = UIColor.shoeBoxBlueColor(0.8)
        girlCheckmarkImageView.alpha = 1.0
        boyCheckmarkImageView.alpha = 0.0
        
        girlBoyTappedCompletion("female")
    }
    
    @IBAction func boyViewTapped(_ gesture: UITapGestureRecognizer) {
        girlBackgroundView.backgroundColor = UIColor.shoeBoxRedColor(0.8)
        boyBackgroundView.backgroundColor = UIColor.shoeBoxBlueColor(0.7)
        girlCheckmarkImageView.alpha = 0.0
        boyCheckmarkImageView.alpha = 1.0
        
        girlBoyTappedCompletion("male")
    }
}
