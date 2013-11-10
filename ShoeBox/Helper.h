//
//  Helper.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/20/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (NSArray *) parseXmlFileOffline:(NSString *) filePath;

+ (NSArray *) parseXmlFileOnline:(NSString *) fileUrl;

@end
