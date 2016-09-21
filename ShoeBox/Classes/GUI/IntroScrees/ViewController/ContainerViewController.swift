//
//  ContainerViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/6/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var buttonStart: ShoeBoxLocalizedButton!
    
    @IBAction func startAction(sender: AnyObject) {
        let preferences = NSUserDefaults.standardUserDefaults()
        preferences.setBool(true, forKey: Constants.KEY_INTRO_COMPLETED)
        SwiftEventBus.post(Constants.GET_INVOLVED_KEY)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
