//
//  ViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 19/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import GoogleMaps
import MessageUI
import UIKit

class MainViewController: UIViewController, MFMailComposeViewControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (!NSUserDefaults.standardUserDefaults().boolForKey(Constants.KEY_INTRO_COMPLETED)) {
            performSegueWithIdentifier("ShowIntroScreenIdentifier", sender: nil)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        SwiftEventBus.onMainThread(self, name: "selectedMenu") { result in
            let menu = result.object as! String
            switch menu {
            case ShoeBoxMenuOptions.ShoeBox.rawValue :

                break
            case ShoeBoxMenuOptions.Contact.rawValue :
                self.launchEmail()
                break
            case ShoeBoxMenuOptions.About.rawValue :

                break
            default:
                break
            }
        }
    }

    override func viewWillDisappear(animated: Bool) {
        SwiftEventBus.unregister(self)
    }
    
    func launchEmail() {
        let emailTitle = "ShoeBox iOS"
        let toRecipents = ["contact@shoebox.ro"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setToRecipients(toRecipents)
        
        self.presentViewController(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail sent failure: %@", [error?.localizedDescription])
        default:
            break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}

