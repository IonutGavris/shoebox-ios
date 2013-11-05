//
//  Helper.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/20/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "Helper.h"
#import "XMLParser.h"

@implementation Helper

+ (NSArray *) parseXmlFileOffline:(NSString *) filePath{
    NSBundle *bundle = [NSBundle mainBundle];
	NSString *textFilePath = [bundle pathForResource:filePath ofType:@"xml"];
    if(textFilePath != nil){
        return [self parseStream:[NSInputStream inputStreamWithFileAtPath:textFilePath]];
    }
    return nil;
}

+ (NSArray *) parseXmlFileOnline:(NSString *) fileUrl{
    NSData *fetchedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileUrl]];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"update.xml"];
    if([fetchedData writeToFile:filePath atomically:YES]){
        return [self parseStream:[NSInputStream inputStreamWithFileAtPath:filePath]];
    }
    return nil;
}

+ (NSArray *) parseStream:(NSInputStream *)inputStream{
    // create and init NSXMLParser object
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithStream:inputStream];
    
    // create and init our delegate
    XMLParser *parser = [[XMLParser alloc] initXMLParser];
    
    // set delegate
    [nsXmlParser setDelegate:parser];
    
    // parsing...
    BOOL success = [nsXmlParser parse];
    
    // test the result
    if (success) {
        NSLog(@"No errors - user count : %i", [[parser getLocations] count]);
        // get array of users here
        return [parser getLocations];
    } else {
        NSLog(@"Error parsing document!");
        return nil;
    }
}

@end
