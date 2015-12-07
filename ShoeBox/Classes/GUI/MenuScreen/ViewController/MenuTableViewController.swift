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
    let contactIdentifier = "Contact"
    let shoeboxIdentifier = "ShoeBox"

    override func viewDidLoad() {
        super.viewDidLoad()

        slidingVC.anchorRightRevealAmount = CGRectGetWidth(self.tableView.bounds) - anchorDefaultOffset
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        SwiftEventBus.postToMainThread("selectedMenu", sender: segue.identifier)

        if segue.identifier == contactIdentifier || segue.identifier == shoeboxIdentifier {
            slideState = .Close
        }
    }
    
    @IBAction func unwindToMenuViewController(segue: UIStoryboardSegue) {
        var enableInteraction = true
        switch slideState {
        case .Close:
            slideState = .Open
            enableInteraction = false
            break
        case .Open:
            slideState = .Close
            slidingVC.resetTopViewAnimated(true)
            break
        }
        
        for view in slidingVC.topViewController.view.subviews {
            if !view.isMemberOfClass(UINavigationBar.self) {
                view.userInteractionEnabled = enableInteraction
            }
        }
    }


}
