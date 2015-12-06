//
//  MenuTableViewController.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 28/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

enum ShoeBoxSliderState: String {
    case Close = "Close"
    case Open = "Open"
}

enum ShoeBoxMenuOptions: String {
    case ShoeBox = "ShoeBox"
    case Contact = "Contact"
    case About = "About"
}

class MenuTableViewController: UITableViewController {

    var slidingVC: ECSlidingViewController {
        return self.slidingViewController()

    }
    
    var slideState: ShoeBoxSliderState = .Close
    
    let anchorDefaultOffset: CGFloat = 54.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        slidingVC.anchorRightRevealAmount = CGRectGetWidth(self.tableView.bounds) - anchorDefaultOffset
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        SwiftEventBus.postToMainThread("selectedMenu", sender: segue.identifier)
    }
    
    @IBAction func unwindToMenuViewController(segue: UIStoryboardSegue) {
        switch slideState {
        case .Close:
            slideState = .Open
            break
        case .Open:
            slideState = .Close
            slidingVC.resetTopViewAnimated(true)
            break
        }
    }


}
