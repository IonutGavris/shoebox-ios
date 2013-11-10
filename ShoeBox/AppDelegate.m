//
//  AppDelegate.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDataObject.h"
#import "ShoeBoxViewController.h"
#import "NewsViewController.h"
#import "MapViewController.h"
#import "ContactViewController.h"

@implementation AppDelegate

@synthesize theAppDataObject;

bool ENABLE_IPAD = false;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.theAppDataObject = [[AppDataObject alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2, *viewController3, *viewController4;
    UINavigationController *navigationcontroller1, *navigationcontroller2, *navigationcontroller3, *navigationcontroller4;
    if (!ENABLE_IPAD || [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[ShoeBoxViewController alloc] initWithNibName:@"ShoeBoxViewController_iPhone" bundle:nil];
        viewController2 = [[NewsViewController alloc] initWithNibName:@"NewsViewController_iPhone" bundle:nil];
        viewController3 = [[MapViewController alloc] initWithNibName:@"MapViewController_iPhone" bundle:nil];
        viewController4 = [[ContactViewController alloc] initWithNibName:@"ContactViewController_iPhone" bundle:nil];
    } else {
        viewController1 = [[ShoeBoxViewController alloc] initWithNibName:@"ShoeBoxViewController_iPad" bundle:nil];
        viewController2 = [[NewsViewController alloc] initWithNibName:@"NewsViewController_iPad" bundle:nil];
        viewController3 = [[MapViewController alloc] initWithNibName:@"MapViewController_iPhone" bundle:nil];
        viewController4 = [[ContactViewController alloc] initWithNibName:@"ContactViewController_iPad" bundle:nil];
    }
    
    navigationcontroller1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    navigationcontroller2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    navigationcontroller3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    navigationcontroller4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navigationcontroller1, navigationcontroller2, navigationcontroller3, navigationcontroller4, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
