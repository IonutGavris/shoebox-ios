//
//  SQLiteDatabase.h
//  eurogsm
//
//  Created by Ionut Gavris on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h> // Import the SQLite database framework

@interface SQLiteDatabase : NSObject {
    // Database variables
	NSString *databaseName;
	NSString *databasePath;
}

-(id) initWithDatabaseName:(NSString *)name;

-(void) checkAndCreateDatabase;

-(void) insertStoresInDb:(NSArray *)stores;

-(NSArray *) readStoresFromDatabase;

-(NSArray *) readStoresFromDatabaseWhereCity:(NSString *)city;

-(NSArray *) readCityesFromDatabase;

-(NSNumber *) countRecordsFromDatabase;

-(void) clearDatabase;

@end
