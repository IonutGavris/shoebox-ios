//
//  AppDelegate.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegateProtocol.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, AppDelegateProtocol>
{
    AppDataObject *theAppDataObject;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, retain) AppDataObject *theAppDataObject;

@end
