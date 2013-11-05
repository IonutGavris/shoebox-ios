//
//  XMLParser.m
//  eurogsm
//
//  Created by Ionut Gavris on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
#import "Location.h"

@implementation XMLParser

@synthesize location, locations;

- (XMLParser *) initXMLParser {
    self = [super init];
    // init array of user objects 
    locations = [[NSMutableArray alloc] init];
    return self;
}

// Parse the start of an element
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName 
    attributes:(NSDictionary *)attributeDict {
	
    if ([elementName isEqualToString:@"location"]) {
        NSLog(@"location element found – create a new instance of Location class...");
        location = [[Location alloc] init];
        //We do not have any attributes in the user elements, but if
        // you do, you can extract them here: 
        // user.att = [[attributeDict objectForKey:@"<att name>"] ...];
    }
}

// Parse an element value
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //  Removing whitspace and newline characters
    NSString *test   =   [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //  If no characters are left return
    if([test length] == 0) return;
    
    if (!currentElementValue) {
        // init the ad hoc string with the value     
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    } else {
        // append value to the ad hoc string    
        [currentElementValue appendString:string];
    }
    NSLog(@"Processing value for : %@", string);
}  

// Parse the end of an element
- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"locations"]) {
        // We reached the end of the XML document
        return;
    }
    
    if ([elementName isEqualToString:@"location"]) {
        // We are done with user entry – add the parsed user 
        // object to our user array
        [locations addObject:location];
        location = nil;
    } else {
        // The parser hit one of the element values. 
        // This syntax is possible because User object 
        // property names match the XML user element names   
        [location setValue:currentElementValue forKey:elementName];
    }
    currentElementValue = nil;
}

- (NSMutableArray *) getLocations{
    return locations;
}





@end
