//
//  AppDataObject.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/20/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface AppDataObject : NSObject
{
    NSMutableArray *_storeList;
    NSMutableArray *_newsList;
    
    BOOL _updatingApplication;
}

@property (nonatomic, copy) Location *_selectedLocation;

- (void) clearData;
- (void) setIsUpdatingApplication:(BOOL)updating;
- (BOOL) isUpdatingApplication;

- (NSMutableArray *) getLocations;
- (NSMutableArray *) getNews;

@end
