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
    _fromMap = NO;
    _fromDetails = NO;
    _fromSearch = NO;
    _updatingApplication = NO;
    _selectedLocation = nil;
}

- (void) clearData {
    _storeList = nil;
    _newsList = nil;
    _fromMap = NO;
    _fromDetails = NO;
    _fromSearch = NO;
    _updatingApplication = NO;
    _selectedLocation = nil;
}

- (void) setFromMap:(BOOL)fromMap{
    _fromMap = fromMap;
}

- (void) setFromDetails:(BOOL)fromDetails{
    _fromDetails = fromDetails;
}

- (void) setFromSearch:(BOOL)fromSearch{
    _fromSearch = fromSearch;
}

- (void) setIsUpdatingApplication:(BOOL)updating{
    _updatingApplication = updating;
}

- (BOOL) isFromMap{
    return _fromMap;
}

- (BOOL) isFromDetails{
    return _fromDetails;
}

- (BOOL) isFromSearch{
    return _fromSearch;
}

- (BOOL) isUpdatingApplication{
    return _updatingApplication;
}

- (void) setSelectedLocation:(Location *)location
{
    _selectedLocation = location;
}
- (Location *) getSelectedLocation
{
    return _selectedLocation;
}

- (NSArray *) getLocations
{
    if(_storeList != nil)
    {
        return _storeList;
    } else {
        //http://adspedia.ro/shoebox/shoebox_locations.xml
        _storeList = [[NSMutableArray alloc]initWithArray:[Helper parseXmlFileOffline:@"shoebox_locations"]];
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
