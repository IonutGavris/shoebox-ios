//
//  Store.m
//  eurogsm
//
//  Created by Ionut Gavris on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize id;
@synthesize city;
@synthesize streetAddress;
@synthesize details;
@synthesize phoneOne;
@synthesize phoneTwo;
@synthesize hours;
@synthesize contactOne;
@synthesize contactTwo;
@synthesize latitude;
@synthesize longitude;

-(id)initWithId:(NSNumber *)itemId city:(NSString *)c streetAddress:(NSString *)e
        details:(NSString *)d phoneOne:(NSString *)po phoneTwo:(NSString *)pt
          hours:(NSString *)h contactOne:(NSString *)co contactTwo:(NSString *)ct
       latitude:(NSString *)la longitude:(NSString *)lo {

    self.id = itemId;
    self.city = c;
    self.streetAddress = e;
    self.details = d;
    self.phoneOne = po;
    self.phoneTwo = pt;
    self.hours = h;
    self.contactOne = co;
    self.contactTwo = ct;
    self.latitude = la;
    self.longitude = lo;
    
    return self;
  }

-(void)setValue:(NSString *)value forKey:(NSString *)key{
    if([key isEqualToString:@"locationCity"]){
        self.city = value;
    }else if([key isEqualToString:@"locationStreetAddress"]){
        self.streetAddress = value;
    }else if([key isEqualToString:@"locationDetails"]){
        self.details = value;
    }else if([key isEqualToString:@"locationPhoneNo1"]){
        self.phoneOne = value;
    }else if([key isEqualToString:@"locationPhoneNo2"]){
        self.phoneTwo = value;
    }else if([key isEqualToString:@"locationHours"]){
        self.hours = value;
    }else if([key isEqualToString:@"locationContact1"]){
        self.contactOne = value;
    }else if([key isEqualToString:@"locationContact2"]){
        self.contactTwo = value;
    }else if([key isEqualToString:@"locationLatitude"]){
        self.latitude = value;
    }else if([key isEqualToString:@"locationLongitude"]){
        self.longitude = value;
    }
}

- (id)copyWithZone:(NSZone *)zone
{
	Location *myClassInstanceCopy = [[Location allocWithZone: zone] init];
    
    myClassInstanceCopy.id = id;
    myClassInstanceCopy.city = city;
    myClassInstanceCopy.streetAddress = streetAddress;
    myClassInstanceCopy.details = details;
    myClassInstanceCopy.phoneOne = phoneOne;
    myClassInstanceCopy.phoneTwo = phoneTwo;
    myClassInstanceCopy.hours = hours;
    myClassInstanceCopy.contactOne = contactOne;
    myClassInstanceCopy.contactTwo = contactTwo;
    myClassInstanceCopy.latitude = latitude;
    myClassInstanceCopy.longitude = longitude;
    
	return myClassInstanceCopy;
}

@end
