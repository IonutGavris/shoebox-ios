//
//  Helper.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/20/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Helper : NSObject

+ (NSArray *) parseXmlFileOffline:(NSString *) filePath;
+ (NSArray *) parseXmlFileOnline:(NSString *) fileUrl;

+ (void)showLocationsScreen:(id)sender;
+ (void)showLocationDetailScreen:(id)sender;
+ (void)showSocialScreen:(id)sender;

+ (Location *) getNearestLocation:(NSArray *)stores startLatitude:(double)startLatitude startLongitude:(double)startLongitude;
+ (double) getDistanceWithStartLatitude:(double)startLatitude startLongitude:(double)startLongitude endLatitude:(double)endLatitude endLongitude:(double)endLongitude;
+ (void)dialNumber:(NSString *)number;

+ (int) getOSVersion;

@end
