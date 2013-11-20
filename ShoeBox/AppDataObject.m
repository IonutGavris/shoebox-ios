//
//  AppDataObject.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/20/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "AppDataObject.h"
#import "Helper.h"

@implementation AppDataObject

- (void) dealloc {
    _storeList = nil;
    _newsList = nil;
    _updatingApplication = NO;
}

- (void) clearData {
    _storeList = nil;
    _newsList = nil;
    _updatingApplication = NO;
}

- (void) setIsUpdatingApplication:(BOOL)updating{
    _updatingApplication = updating;
}

- (BOOL) isUpdatingApplication{
    return _updatingApplication;
}

- (NSArray *) getLocations
{
    if(_storeList != nil)
    {
        return _storeList;
    } else {
        //Load from web/cache
        NSArray *locationsList = [Helper parseXmlFileOnline:@"http://shoebox.ro/app/shoebox_locations.xml"];
        
        //Load from local data
        if(locationsList == nil) {
            locationsList = [Helper parseXmlFileOffline:@"shoebox_locations"];
        }
        
        NSArray *sortedLocationsList = [locationsList sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *first = [(Location*)a city];
            NSString *second = [(Location*)b city];
            return [first compare:second];
        }];
        _storeList = [[NSMutableArray alloc]initWithArray:sortedLocationsList];
        return _storeList;
    }
}

- (NSArray *) getNews
{
    if(_newsList != nil)
    {
        return _newsList;
    } else {
        _newsList = [[NSMutableArray alloc]init];
        return _newsList;
    }
}

@end
