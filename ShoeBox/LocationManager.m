//
//  LocationManager.m
//  eurogsm
//
//  Created by Ionut Gavris on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

static CLLocationManager *locationManager;
static LocationManager *sharedSingleton;
static id <LocationManagerProtocol> receiver;
static BOOL initialized = NO;

static NSMutableArray *locationMeasurements;
static CLLocation *bestEffortAtLocation;

static NSString *latitude;
static NSString *longitude;
static NSString *timestamp;

+ (void)initialize
{    
    if(!initialized)
    {
        initialized = YES;
        sharedSingleton = [[LocationManager alloc] init];
    }
}

- (id) initWithAccuracy:(CLLocationAccuracy) accuracy{
    // Create the manager object 
    if(locationManager == nil){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
    }
    // This is the most important property to set for the manager. It ultimately determines how the manager will
    // attempt to acquire location and thus, the amount of power that will be consumed.
    locationManager.desiredAccuracy = accuracy;
    
    return self;
}

#pragma mark - Location Manager

/*
 * We want to get and store a location measurement that meets the desired accuracy. For this example, we are
 *      going to use horizontal accuracy as the deciding factor. In other cases, you may wish to use vertical
 *      accuracy, or both together.
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // store all of the measurements, just so we can see what kind of data we might receive
    //[locationMeasurements addObject:newLocation];
    // test the age of the location measurement to determine if the measurement is cached
    
	// in most cases you will not want to rely on cached measurements
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    
	// test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;
    
	// test the measurement to see if it is more accurate than the previous measurement
    if (bestEffortAtLocation == nil || bestEffortAtLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        // store the location as the "best effort"

            bestEffortAtLocation = newLocation;
            // test the measurement to see if it meets the desired accuracy
            //
            // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue 
            // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of 
            // acceptable accuracy, or depend on the timeout to stop updating. This sample depends on the timeout.
            //
            if (newLocation.horizontalAccuracy <= locationManager.desiredAccuracy) {
                // we have a measurement that meets our requirements, so we can stop updating the location
                // 
                // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
                //
                [self stopUpdatingLocation:NSLocalizedString(@"Acquired Location", @"Acquired Location")];
                // we can also cancel our previous performSelector:withObject:afterDelay: - it's no longer necessary
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation:) object:nil];
                
            }
           
            latitude = [NSString stringWithFormat:(@"%.5lf"),newLocation.coordinate.latitude];
            longitude = [NSString stringWithFormat:(@"%.5lf"),newLocation.coordinate.longitude];
            timestamp = [NSString stringWithFormat:(@"%@"),newLocation.timestamp];
        
        NSLog(@"Location received!");

        [receiver locationReceived:newLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // The location "unknown" error simply means the manager is currently unable to get the location.
    // We can ignore this error for the scenario of getting a single location fix, because we already have a 
    // timeout that will stop the location manager to save power.
    if ([error code] != kCLErrorLocationUnknown) {
        [self stopUpdatingLocation:NSLocalizedString(@"Error", @"Error")];
    }
}

- (void) stopUpdatingLocation:(NSString *)status{
    [locationManager stopUpdatingLocation];
}

- (void)stopUpdatingLocationForDelegate:(id)delegate {
    [locationManager stopUpdatingLocation];
    if(receiver == delegate){
        receiver = nil;
    } else if(receiver != nil) {
        NSLog(@"A view forgot to stop the LocationManager!");
    }
}

- (void)startUpdatingLocationForDelegate:(id)delegate {
    [locationMeasurements removeAllObjects];
    receiver = delegate;
    if(bestEffortAtLocation != nil){
        [receiver locationReceived:bestEffortAtLocation];
        bestEffortAtLocation = nil;
    }
    [locationManager startUpdatingLocation];
}

@end
