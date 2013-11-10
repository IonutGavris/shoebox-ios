//
//  LocationManager.h
//  eurogsm
//
//  Created by Ionut Gavris on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManagerProtocol.h"

@interface LocationManager : NSObject <CLLocationManagerDelegate> {
}

- (id) initWithAccuracy:(CLLocationAccuracy) accuracy;
- (void) stopUpdatingLocationForDelegate:(id)delegate;
- (void) startUpdatingLocationForDelegate:(id)delegate;
- (void) stopUpdatingLocation:(NSString *)status;

@end
