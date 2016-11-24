//
//  MainViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 19/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit
import MessageUI
import Social

class MainViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        if !UserDefaults.standard.bool(forKey: Constants.KEY_INTRO_COMPLETED) {
            showIntroViewController(animated: false)
        }
    }
    
    @IBAction func moreButtonTapped(_ sender: UIBarButtonItem) {
        
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
       
        let actionCancel = UIAlertAction(title: NSLocalizedString("shoeBox_more_info_cancel",
                                                                  comment: ""), style: .cancel, handler: nil)
        controller.addAction(actionCancel)
        
        let aboutUs = UIAlertAction(title: NSLocalizedString("shoeBox_more_info_about",
                                                             comment: ""), style: .default,
                                                                           handler: { [weak self] (action) in
            self?.showIntroViewController()
        })
        controller.addAction(aboutUs)
        
        let contactUs = UIAlertAction(title: NSLocalizedString("shoeBox_more_info_contact", comment: ""),
                                      style: .default, handler: { [weak self] (action) in
            self?.showMailScreen()
        })
        
        controller.addAction(contactUs)
        
        present(controller, animated: true, completion: nil)
    }
    
    //MARK: MFMailComposeViewControllerDelegate
    
    
    func mailComposeController(_ controller:MFMailComposeViewController,
                               didFinishWith result:MFMailComposeResult, error:Error?) {
        
         switch result {
         case .cancelled:
            print("Mail cancelled")
         case .saved:
            print("Mail saved")
         case.sent:
            print("Mail sent")
         case .failed:
            print("Mail sent failure: %@", [error?.localizedDescription])
         }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        
        let title = NSLocalizedString("shoeBox_share_title", comment: "")
        var sharedItems: [Any] = [title]

        if let url = URL(string: NSLocalizedString("shoeBox_share_appstore_url", comment: "")) {
            sharedItems.append(url)
        }
        
        let image = #imageLiteral(resourceName: "app_launcher_store")
        sharedItems.append(image)
        
        let activityViewController = UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = sender
        activityViewController.excludedActivityTypes = excludedActivityTypes
        activityViewController.completionWithItemsHandler = { (activityType, completed, items, error) in
            
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: Private methods
    
    private func showIntroViewController(animated: Bool = true) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "IntroViewController") {
            present(vc, animated: animated, completion: nil)
        }
    }

    private func showMailScreen() {
        
        let emailTitle = NSLocalizedString("shoeBox_email_title", comment: "")
        let toRecipents = ["contact@shoebox.ro"]
       
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setToRecipients(toRecipents)
        
        if MFMailComposeViewController.canSendMail() {
            present(mc, animated: true, completion: nil)

        }
    }
}

extension MainViewController {
    
    fileprivate var excludedActivityTypes: [UIActivityType] {
    
        return [.postToWeibo,
                .print,
                .message,
                .mail,
                .copyToPasteboard,
                .assignToContact,
                .saveToCameraRoll,
                .addToReadingList,
                .postToTencentWeibo,
                .airDrop,
                .openInIBooks
        ]
    }
}

