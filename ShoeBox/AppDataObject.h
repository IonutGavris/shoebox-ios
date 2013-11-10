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
    Location *_selectedLocation;
    
    BOOL _fromMap;
    BOOL _fromDetails;
    BOOL _fromSearch;
    BOOL _updatingApplication;
}

@property (nonatomic, copy) Location *_selectedLocation;

- (void) clearData;
- (void) setFromMap:(BOOL)fromMap;
- (void) setFromDetails:(BOOL)fromDetails;
- (void) setFromSearch:(BOOL)fromSearch;
- (void) setIsUpdatingApplication:(BOOL)updating;
- (BOOL) isFromMap;
- (BOOL) isFromDetails;
- (BOOL) isFromSearch;
- (BOOL) isUpdatingApplication;
- (void) setSelectedLocation:(Location *)location;
- (Location *) getSelectedLocation;

- (NSMutableArray *) getLocations;
- (NSMutableArray *) getNews;

@end
