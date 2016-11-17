//
//  ViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 19/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    deinit {
        SwiftEventBus.unregister(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        if (!UserDefaults.standard.bool(forKey: Constants.KEY_INTRO_COMPLETED)) {
            self.selectedIndex = 1
        }
        
        
        SwiftEventBus.onMainThread(self, name: Constants.GET_INVOLVED_KEY) { (notif) in
            self.selectedIndex = 0
        }
    }
}

