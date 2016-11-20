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
import WTGlyphFontSet

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

        return true
    }

}

