//
//  PageViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 12/5/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}