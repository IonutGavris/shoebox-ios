//
//  MapAnnotation.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/20/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MapAnnotation : NSObject <MKAnnotation>{
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
    NSNumber *_index;
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSNumber *index;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate index:(NSNumber*)index;


@end
