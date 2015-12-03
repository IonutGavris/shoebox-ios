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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMenuViewController(segue: UIStoryboardSegue) {
        switch slideState {
        case .Close:
            slideState = .Open
            allowUserInteraction = false
            break
        case .Open:
            slideState = .Close
            slidingVC.resetTopViewAnimated(true)
            break
        }
    }


}
