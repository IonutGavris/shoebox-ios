//
//  XMLParser.h
//  eurogsm
//
//  Created by Ionut Gavris on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@interface XMLParser : NSObject <NSXMLParserDelegate>{
    // an ad hoc string to hold element value
    NSMutableString *currentElementValue;
    // store object
    Location *location;
    // array of user objects
    NSMutableArray *locations;
}

@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) NSMutableArray *locations;

- (XMLParser *) initXMLParser;

- (NSMutableArray *) getLocations;

@end
