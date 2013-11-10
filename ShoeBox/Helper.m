//
//  Helper.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/20/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "Helper.h"
#import "XMLParser.h"
#import "LocationsViewController.h"
#import "LocationsDetailsViewController.h"

@implementation Helper

+ (NSArray *) parseXmlFileOffline:(NSString *) filePath{
    NSBundle *bundle = [NSBundle mainBundle];
	NSString *textFilePath = [bundle pathForResource:filePath ofType:@"xml"];
    if(textFilePath != nil){
        return [self parseStream:[NSInputStream inputStreamWithFileAtPath:textFilePath]];
    }
    return nil;
}

+ (NSArray *) parseXmlFileOnline:(NSString *) fileUrl{
    NSData *fetchedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileUrl]];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"update.xml"];
    if([fetchedData writeToFile:filePath atomically:YES]){
        return [self parseStream:[NSInputStream inputStreamWithFileAtPath:filePath]];
    }
    return nil;
}

+ (NSArray *) parseStream:(NSInputStream *)inputStream{
    // create and init NSXMLParser object
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithStream:inputStream];
    
    // create and init our delegate
    XMLParser *parser = [[XMLParser alloc] initXMLParser];
    
    // set delegate
    [nsXmlParser setDelegate:parser];
    
    // parsing...
    BOOL success = [nsXmlParser parse];
    
    // test the result
    if (success) {
        NSLog(@"No errors - user count : %i", [[parser getLocations] count]);
        // get array of users here
        return [parser getLocations];
    } else {
        NSLog(@"Error parsing document!");
        return nil;
    }
}

+ (void)showLocationsScreen:(id)sender {
    bool isIphone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    NSString *viewControllerNib;
    
    if(isIphone) {
        viewControllerNib = @"LocationsViewController_iPhone";
    } else {
        viewControllerNib = @"LocationsViewController_iPad";
    }
    
    LocationsViewController *addController = [[LocationsViewController alloc]
                                         initWithNibName:viewControllerNib bundle:nil];
    [[sender navigationController] pushViewController:addController  animated:YES];
}

+ (void)showLocationDetailScreen:(id)sender {
    bool isIphone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    NSString *viewControllerNib;
    
    if(isIphone) {
        viewControllerNib = @"LocationsDetailsViewController_iPhone";
    } else {
        viewControllerNib = @"LocationsDetailsViewController_iPad";
    }
    
    LocationsDetailsViewController *addController = [[LocationsDetailsViewController alloc]
                                              initWithNibName:viewControllerNib bundle:nil];
    [[sender navigationController] pushViewController:addController  animated:YES];
}

+ (double) getDistanceWithStartLatitude:(double)startLatitude startLongitude:(double)startLongitude endLatitude:(double)endLatitude endLongitude:(double)endLongitude
{
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:startLatitude longitude:startLongitude];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:endLatitude longitude:endLongitude];
    CLLocationDistance theDistance = [locA distanceFromLocation:locB];
    
    return  theDistance / 1000;
}

+ (Location *) getNearestLocation:(NSArray *)stores startLatitude:(double)startLatitude startLongitude:(double)startLongitude  {
    Location *nearestStore;
    double nearestDistance = -1;
    
    //we create a number formater for gps coordinates
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    for (int i=0;i<[stores count];i++) {
        Location *store = [stores objectAtIndex:i];
        
        //we set the pin details
        NSNumber * latitude = [f numberFromString:store.latitude];
        NSNumber * longitude = [f numberFromString:store.longitude];
        
        double currentDistance = [self getDistanceWithStartLatitude:startLatitude startLongitude:startLongitude endLatitude:latitude.doubleValue endLongitude:longitude.doubleValue];
        
        if(nearestDistance == -1 || currentDistance < nearestDistance){
            nearestDistance = currentDistance;
            nearestStore = store;
            NSLog(@"distance: %lf", currentDistance);
            
        }
        
    }
    if(nearestStore != nil && nearestDistance != -1){
        return nearestStore;
    }
    return nil;
}

+ (void)dialNumber:(NSString *)number {
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        NSMutableString *url = [[NSMutableString alloc]initWithString:@"tel://"];
        [url appendString:number];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alerta" message:@"Dispozitivul dumneavoastra nu suporta aceasta functionalitate!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
    }
}

+ (int) getOSVersion
{
    NSString *ver = [[UIDevice currentDevice] systemVersion];
    return [ver intValue];
}

@end
