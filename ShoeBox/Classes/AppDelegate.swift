//
//  AppDelegate.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 19/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Firebase
import GoogleSignIn

import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        WTGlyphFontSet.loadFont("icomoon", filename: "icomoon.ttf")
        WTGlyphFontSet.setDefaultFontSetName("icomoon")
        
        Fabric.with([Crashlytics.self])
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
        UIApplication.shared.registerNotifications()
        
        return true
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        if let invite = FIRInvites.handle(url, sourceApplication:sourceApplication, annotation:"") as? FIRReceivedInvite {
            let matchType =
                (invite.matchType == .weak) ? "Weak" : "Strong"
            print("Invite received from: \(sourceApplication) Deeplink: \(invite.deepLink)," +
                "Id: \(invite.inviteId), Type: \(matchType)")
            return true
        }
        
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: "")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate, FIRMessagingDelegate {

    //MARK: UIApplicationDelegate
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: .unknown)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        if #available(iOS 10.0, *) {
            return
        }
        
    }
    
    //MARK: FIRMessagingDelegate
    
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        
    }
    
    //MARK: UNUserNotificationCenterDelegate
    
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        completionHandler([.sound, .badge])
    }
    
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {

        completionHandler()
    }
}

