//
//  UIApplication+Notifications.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 28/11/2016.
//  Copyright © 2016 ShoeBox. All rights reserved.
//

import Foundation
import UserNotifications
import Firebase

extension UIApplication {
    
    func registerNotifications() {
        
        if #available(iOS 10.0, *) {
            
            let appdelegate = UIApplication.shared.delegate as? AppDelegate
            UNUserNotificationCenter.current().delegate = appdelegate
            FIRMessaging.messaging().remoteMessageDelegate = appdelegate 

            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (accepted, error) in
                if accepted {
                    self.registerForRemoteNotifications()
                }
            })
        } else {
            let userNotificationTypes: UIUserNotificationType = [.alert, .badge, .sound]
            let settings = UIUserNotificationSettings(types: userNotificationTypes, categories: nil)
            
            registerUserNotificationSettings(settings)
            registerForRemoteNotifications()
        }
    }
    
    func unregisterNotifications() {
        unregisterForRemoteNotifications()
    }

}
