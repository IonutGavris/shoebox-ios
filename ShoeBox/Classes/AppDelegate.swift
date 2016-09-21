//
//  AppDelegate.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 19/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit
import Fabric
import GoogleMaps
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        WTGlyphFontSet.loadFont("icomoon", filename: "icomoon.ttf")
        WTGlyphFontSet.setDefaultFontSetName("icomoon")
        
        Fabric.with([Crashlytics.self])
        Firebase.defaultConfig().persistenceEnabled = true
        GMSServices.provideAPIKey("AIzaSyDFuQRN2Vx3TfSwbybE9VGaZs4fJO3pXHQ")
        return true
    }

}

