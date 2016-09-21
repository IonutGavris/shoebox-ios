//
//  ContactsViewController.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 21/09/16.
//  Copyright © 2016 ShoeBox. All rights reserved.
//

import UIKit
import MessageUI

class ContactsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let emailTitle = "ShoeBox iOS"
        let toRecipents = ["contact@shoebox.ro"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setToRecipients(toRecipents)
        
        //self.presentViewController(mc, animated: true, completion: nil)
    }

    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError?) {
        /*
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
         */
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
