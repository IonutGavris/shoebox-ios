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

@interface LocationsDetailsViewController : UITableViewController <MFMailComposeViewControllerDelegate, LocationManagerProtocol>
{
    IBOutlet UITableView *tableViewDetails;
    LocationManager *_locationManager;
    double distance;
}
    
@property (nonatomic, retain) IBOutlet UITableView *tableViewDetails;
@property (nonatomic, retain) LocationManager *locationManager;

@end
