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

