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
