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
    var imageName: String!
    var labelText: String!
    
    @IBOutlet weak var imageContent: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.clear
        imageContent.image = UIImage(named: imageName)
        labelDescription.text = labelText
        labelDescription.accessibilityIdentifier = String(pageIndex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
