//
//  Location.h
//  shoebox
//
//  Created by Ionut Gavris on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject <NSCopying> {
    NSNumber * id;
    NSString * city;
    NSString * streetAddress;
    NSString * details;
    NSString * phoneOne;
    NSString * phoneTwo;
    NSString * hours;
    NSString * contactOne;
    NSString * contactTwo;
    NSString * latitude;
    NSString * longitude;
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * streetAddress;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * phoneOne;
@property (nonatomic, retain) NSString * phoneTwo;
@property (nonatomic, retain) NSString * hours;
@property (nonatomic, retain) NSString * contactOne;
@property (nonatomic, retain) NSString * contactTwo;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;

-(id)initWithId:(NSNumber *)itemId city:(NSString *)c streetAddress:(NSString *)e
         details:(NSString *)d phoneOne:(NSString *)po phoneTwo:(NSString *)pt
           hours:(NSString *)h contactOne:(NSString *)co contactTwo:(NSString *)ct
        latitude:(NSString *)la longitude:(NSString *)lo;

-(void)setValue:(NSString *)value forKey:(NSString *)key;

@end
