//
//  MapViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Location.h"
#import "MapAnnotation.h"
#import "SQLiteDatabase.h"
#import "LocationsDetailsViewController.h"
#import "LocationsViewController.h"
#import "LocationManager.h"
#import "AppDelegateProtocol.h"
#import "AppDataObject.h"
#import "Helper.h"

#define METERS_PER_MILE 1609.344

@implementation MapViewController
@synthesize mapView;
@synthesize currentLocation = _currentLocation;
@synthesize locationManager = _locationManager;
@synthesize fromDetails, selectedLocation;

bool centeredOnce;

- (AppDataObject*) theAppDataObject;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	AppDataObject* theDataObject;
	theDataObject = (AppDataObject*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Locatii", @"Locatii");
        self.tabBarItem.image = [UIImage imageNamed:@"locatii"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mapView.delegate = self;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 45.690833;
    zoomLocation.longitude = 24.609375;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 500*METERS_PER_MILE, 500*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:YES];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        if([[self theAppDataObject] getLocations] != nil) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self addToMapStores:[[self theAppDataObject] getLocations]];
                if(fromDetails) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        int *index = [[self theAppDataObject].getLocations  indexOfObject:selectedLocation];
                        NSNumber *nsIndex = [NSNumber numberWithInt:index];
                        for (int i=0; i < [mapView.annotations count]; i++) {
                            MapAnnotation *annotation = [mapView.annotations objectAtIndex:i];
                            if(![annotation isKindOfClass:[MKUserLocation class]] && annotation.index == nsIndex) {
                                [mapView selectAnnotation:annotation animated:true];
                                break;
                            }
                        }
                    });
                }
            });
        }
    });

    _locationManager = [[LocationManager alloc] initWithAccuracy:kCLLocationAccuracyBest];
}

- (void)viewDidUnload
{
    mapView = nil;
    _locationManager = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[[self theAppDataObject] setFromMap:NO];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //we check to see if we need to focus on a store
    //else we request a position from LocationManager
    
    if(selectedLocation != nil && fromDetails){
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = [selectedLocation.latitude doubleValue];
        zoomLocation.longitude = [selectedLocation.longitude doubleValue];

        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
        [mapView setRegion:adjustedRegion animated:YES];
    }
    
    [_locationManager startUpdatingLocationForDelegate:self];
}

- (void) viewWillDissapear:(BOOL)animated{
    [_locationManager stopUpdatingLocationForDelegate:self];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Add the stores to the map
- (void)addToMapStores:(NSArray *)stores {
    
    for (id<MKAnnotation> annotation in mapView.annotations) {
        [mapView removeAnnotation:annotation];
    }
    
    for (int i=0;i<[stores count];i++) {
        Location *store = [stores objectAtIndex:i];
        //we create a number formater for gps coordinates
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        
        //we set the pin details
        NSNumber * latitude = [f numberFromString:store.latitude];
        NSNumber * longitude = [f numberFromString:store.longitude];
        NSString * address = store.streetAddress;
        NSString * name = store.details;
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;            
        
        //we init our on implementation of MKAnnotation
        MapAnnotation *annotation = [[MapAnnotation alloc] initWithName:name address:address coordinate:coordinate index:[NSNumber numberWithInt:i]];
        //we add the pin to the map
        [mapView addAnnotation:annotation];
    }
}

- (MKAnnotationView *) mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>) annotation{
    
    //if user allow us to use location
    //and the phone gets a fix
    //tell the map to draw the default blue dot
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if(false) {
         //default initialization used to show map pins
        MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
        annView.pinColor = MKPinAnnotationColorRed;
        annView.animatesDrop=TRUE;
        annView.canShowCallout = YES;
        annView.calloutOffset = CGPointMake(-5, 5);
        annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return annView;
    } else {
        //custom initialization used to show images insead of pins
        //draws the specific annotation view for a store
        static NSString *AnnotationViewID = @"annotationViewID";
        MKAnnotationView *annotationView = (MKAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        
        if (annotationView == nil)
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }
        
        annotationView.image = [UIImage imageNamed:@"shoebox_map.png"];
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(-5, 5);
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.annotation = annotation;
        
        return annotationView;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    if ([view.annotation isKindOfClass:[MapAnnotation class]]) {
        MapAnnotation *tm = (MapAnnotation *)view.annotation;
        AppDataObject* theDataObject = [self theAppDataObject];
        [Helper showLocationDetailScreen:self withLocation:[[theDataObject getLocations] objectAtIndex:[tm.index intValue]] fromMap:YES];
    }
}

- (void) locationReceived:(CLLocation *)location{
    [_locationManager stopUpdatingLocationForDelegate:self];
    
    if(self.currentLocation != nil){
        self.currentLocation = nil;
    }
    
    self.currentLocation = location;
    
    if(!fromDetails && !centeredOnce){
        centeredOnce = true;
        [self centerMapOnLocation:self.currentLocation usingZoom:5.3];
    }
}

- (void) centerMapOnLocation:(CLLocation *)location usingZoom:(double)zoom{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = location.coordinate.latitude;
    zoomLocation.longitude = location.coordinate.longitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoom*METERS_PER_MILE, zoom*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:YES];
}

- (IBAction) barButtonMyLocation:(id)sender {
    if(self.currentLocation != nil){
        [self centerMapOnLocation:self.currentLocation usingZoom:1.0];
    }
}

- (IBAction) barButtonNearestStore:(id)sender {
    if(self.currentLocation != nil){
        Location *location = [Helper getNearestLocation:[[self theAppDataObject] getLocations] startLatitude:self.currentLocation.coordinate.latitude startLongitude:self.currentLocation.coordinate.longitude];
        CLLocation *cclocation = [[CLLocation alloc] initWithLatitude:[location.latitude doubleValue] longitude:[location.longitude doubleValue]];
        [self centerMapOnLocation:cclocation usingZoom:1.0];
    }
}

- (IBAction) barButtonStoreList:(id)sender {
    [Helper showLocationsScreen:self];
}

- (IBAction) barButtonMapMode:(id)sender {
    if(mapView.mapType == MKMapTypeStandard){
        [mapView setMapType:MKMapTypeHybrid];
    } else if (mapView.mapType == MKMapTypeHybrid){
        [mapView setMapType:MKMapTypeSatellite];
    } else {
        [mapView setMapType:MKMapTypeStandard];
    }
    
}

- (void) openNearestStoreWithCurrentLatitude:(double) latitude andLongitude:(double) longitude {
    //SQLiteDatabase *database = [[SQLiteDatabase alloc]initWithDatabaseName:@"StoresDatabase.sql"];
    
    // Pass the selected object to the new view controller.
    AppDataObject* theDataObject = [self theAppDataObject];
    [Helper showLocationDetailScreen:self withLocation:[Helper getNearestLocation:[theDataObject getLocations] startLatitude:latitude startLongitude:longitude] fromMap:YES];
}

@end
