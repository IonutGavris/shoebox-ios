//
//  LocationsDetailsViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "LocationsDetailsViewController.h"
#import "AppDelegateProtocol.h"
#import "AppDataObject.h"
#import "MapViewController.h"
#import "Helper.h"

@interface LocationsDetailsViewController ()

@end

@implementation LocationsDetailsViewController
@synthesize locationManager = _locationManager;
@synthesize currentLocation, fromMap;

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
        // Custom initialization
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
    if([Helper getOSVersion] >= 7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _locationManager = [[LocationManager alloc] initWithAccuracy:kCLLocationAccuracyBest];
    
    if(currentLocation != nil){
        self.title = currentLocation.city;
        [self.textViewAdress setText:currentLocation.streetAddress];
        [self.textViewContact setText:currentLocation.contactOne];
        [self.textViewPhone setText:currentLocation.phoneOne];
        if(currentLocation.latitude == nil || currentLocation.longitude == nil || fromMap)
        {
            [self.buttonMap setHidden:true];
        }
    } else {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_locationManager startUpdatingLocationForDelegate:self];
}

- (void) viewWillDisappear:(BOOL)animated{
    [_locationManager stopUpdatingLocationForDelegate:self];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonCallClick:(id)sender {
    [Helper dialNumber:currentLocation.phoneOne];
}

- (IBAction)buttonMapClick:(id)sender {
    MapViewController *addController = [[MapViewController alloc]
                                        initWithNibName:@"MapViewController_iPhone" bundle:nil];
    [addController setFromDetails:true];
    [addController setLocation:currentLocation];
    [[self navigationController] pushViewController:addController  animated:YES];
}

- (void) locationReceived:(CLLocation *)location{
    [_locationManager stopUpdatingLocationForDelegate:self];
    
    distance = [Helper getDistanceWithStartLatitude:location.coordinate.latitude startLongitude:location.coordinate.longitude endLatitude:[currentLocation.latitude doubleValue] endLongitude:[currentLocation.longitude doubleValue]];
    
    NSString *dist = [NSString stringWithFormat:@"%lf",distance];
    NSRange range = [dist rangeOfString:@"."];
    NSMutableString *mutableDistance = [[NSMutableString alloc]init];
    [mutableDistance appendString:@"Distanta "];
    [mutableDistance appendString:[dist substringToIndex:range.location + 2]];
    [mutableDistance appendString:@" km"];
        
    [self.labelDistance setText:mutableDistance];
    
}

@end
