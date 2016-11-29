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
import Firebase
import GoogleSignIn

class MainViewController: UIViewController, MFMailComposeViewControllerDelegate, FIRInviteDelegate, GIDSignInDelegate, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        if !UserDefaults.standard.bool(forKey: Constants.KEY_INTRO_COMPLETED) {
            showIntroViewController(animated: false)
        }
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Do nothing
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
        
        let inviteFriends = UIAlertAction(title: NSLocalizedString("shoeBox_more_info_invite", comment: ""),
                                      style: .default, handler: { [weak self] (action) in
            self?.inviteFriends()
        })
        
        controller.addAction(inviteFriends)
        
        let shareApp = UIAlertAction(title: NSLocalizedString("shoeBox_more_info_share", comment: ""),
                                          style: .default, handler: { [weak self] (action) in
            self?.shareButtonTapped()
        })
        
        controller.addAction(shareApp)
        
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
    
    private func inviteFriends() {
        if let _ = GIDSignIn.sharedInstance().currentUser {
            if let invite = FIRInvites.inviteDialog() {
                invite.setInviteDelegate(self)
                
                // NOTE: You must have the App Store ID set in your developer console project
                // in order for invitations to successfully be sent.
                
                // A message hint for the dialog. Note this manifests differently depending on the
                // received invation type. For example, in an email invite this appears as the subject.
                var message = NSLocalizedString("shoeBox_invitation_message", comment: "")
                if let name = GIDSignIn.sharedInstance().currentUser.profile.name {
                    message += "\n\n\(name)"
                }
                invite.setMessage(message)
                // Title for the dialog, this is what the user sees before sending the invites.
                invite.setTitle("ShoeBox")
                invite.setDeepLink("app_url")
                invite.setCallToActionText(NSLocalizedString("shoeBox_invitation_cta", comment: ""))
                invite.open()
            }
        } else {
            GIDSignIn.sharedInstance().signIn()
        }
    }
    
    private func shareButtonTapped() {
        
        let title = NSLocalizedString("shoeBox_share_title", comment: "")
        var sharedItems: [Any] = [title]
        
        if let url = URL(string: "https://rww9v.app.goo.gl/cffF") {
            sharedItems.append(url)
        }
        
        let image = #imageLiteral(resourceName: "app_launcher_store")
        sharedItems.append(image)
        
        let activityViewController = UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = excludedActivityTypes
        activityViewController.completionWithItemsHandler = { (activityType, completed, items, error) in
            
        }
        
        present(activityViewController, animated: true, completion: nil)
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

