//
//  MapViewController.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationManagerProtocol.h"
#import "Location.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, LocationManagerProtocol> {
    BOOL *_doneInitialZoom;
    LocationManager *_locationManager;
    CLLocation *_currentLocation;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) LocationManager *locationManager;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) Location *selectedLocation;
@property (nonatomic, assign) BOOL fromDetails;

- (IBAction) barButtonMyLocation:(id)sender;
- (IBAction) barButtonNearestStore:(id)sender;
- (IBAction) barButtonStoreList:(id)sender;
- (IBAction) barButtonMapMode:(id)sender;

@end
