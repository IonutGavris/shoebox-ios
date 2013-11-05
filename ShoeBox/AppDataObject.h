//
//  AppDataObject.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/20/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDataObject : NSObject
{
    NSMutableArray *_storeList;
    NSMutableArray *_newsList;
}

- (NSMutableArray *) getLocations;
- (NSMutableArray *) getNews;

@end
