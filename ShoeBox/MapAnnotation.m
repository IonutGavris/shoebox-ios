//
//  MapAnnotation.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/20/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;
@synthesize index = _index;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate index:(NSNumber*)index {
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        _index = index;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (void)dealloc
{
    _name = nil;
    _address = nil;    
}

@end
