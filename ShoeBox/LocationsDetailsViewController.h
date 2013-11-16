//
//  LocationsDetailsViewController.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "LocationManager.h"
#import "Location.h"

@interface LocationsDetailsViewController : UIViewController <MFMailComposeViewControllerDelegate, LocationManagerProtocol>
{
    LocationManager *_locationManager;
    double distance;
}
@property (weak, nonatomic) IBOutlet UILabel *textViewAdress;
@property (weak, nonatomic) IBOutlet UILabel *textViewContact;
@property (weak, nonatomic) IBOutlet UILabel *textViewPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;
@property (weak, nonatomic) IBOutlet UIButton *buttonMap;

@property (nonatomic, retain) LocationManager *locationManager;
@property (nonatomic, retain) Location *currentLocation;
@property (nonatomic, assign) BOOL fromMap;

@end
