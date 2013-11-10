//
//  SQLiteDatabase.m
//  eurogsm
//
//  Created by Ionut Gavris on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SQLiteDatabase.h"
#import "XMLParser.h"
#import "Location.h"

@implementation SQLiteDatabase

-(id) initWithDatabaseName:(NSString *)name{
    // Setup some globals
    databaseName = name;
    
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    return self;
}


-(void) checkAndCreateDatabase {
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
    
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
    
	// If the database already exists then return without doing anything
	if(success) return;
    
	// If not then proceed to copy the database from the application to the users filesystem
    
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}



-(void) insertStoresInDb:(NSArray *)stores{
    
    if(stores != nil && [stores count] > 0){
        // Setup the database object
        sqlite3 *database;
        
        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK){
            
            // Buildings
            for (Location *store in stores)
            {
                NSLog(@"%@", [store description]);
                sqlite3_stmt *statement = nil;
                NSString* sqlStatement = [NSString stringWithFormat:@"INSERT INTO stores (city, latitude, longitude,name, phone, state, streetAddress) VALUES (\'%@\', \'%@\', \'%@\', \'%@\', \'%@\', \'%@\', \'%@\')",
                                      [store city], [store latitude], [store longitude], [store details],
                                      [store description], [store hours], [store streetAddress]];
            
                NSLog(@"somestring: %@", sqlStatement);
                const char *sql = [sqlStatement cStringUsingEncoding:[NSString defaultCStringEncoding]];
                if(sqlite3_prepare_v2(database, sql, -1, &statement, NULL)!=SQLITE_OK)
                    NSAssert1(0,@"Error preparing statement",sqlite3_errmsg(database));
            
                while(sqlite3_step(statement) == SQLITE_DONE){}
            
                sqlite3_finalize(statement);
            }
        }
        sqlite3_close(database);
    } else {
        NSLog(@"No stores where inserted in DB because the provided array was empty!");
    }
}

-(NSArray *) readStoresFromDatabase {
    
	// Setup the database object
	sqlite3 *database;
    
	// Init the stores Array
	NSMutableArray *stores = [[NSMutableArray alloc] init];
    
    /*
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT * FROM stores";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                NSNumber * id = [NSNumber numberWithInt:(int)sqlite3_column_int(compiledStatement, 0)];
                NSString * city = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString * latitude = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                NSString * longitude = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                NSString * name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
                NSString * phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
                NSString * state = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
                NSString * streetAddress = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
                
				// Create a new animal object with the data from the database
				Location *store = [[Location alloc] initWithId:id city:city email:email image:image latitude:latitude longitude:longitude name:name phone:phone state:state streetAddress:streetAddress];
                
				// Add the animal object to the animals Array
				[stores addObject:store];
                NSLog(@"%@", [store name]);
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);
    */
    return stores;
}

-(NSArray *) readStoresFromDatabaseWhereCity:(NSString *)city {
	// Setup the database object
	sqlite3 *database;
    
	// Init the stores Array
	NSMutableArray *stores = [[NSMutableArray alloc] init];
    
    /*
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
        NSString* statement = [NSString stringWithFormat:@"SELECT * FROM stores WHERE city=\'%@\'", city];
        const char *sqlStatement = [statement cStringUsingEncoding:[NSString defaultCStringEncoding]];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                NSNumber * id = [NSNumber numberWithInt:(int)sqlite3_column_int(compiledStatement, 0)];
                NSString * city = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString * email = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSString * image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                NSString * latitude = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                NSString * longitude = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                NSString * name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
                NSString * phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
                NSString * state = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
                NSString * streetAddress = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
                
				// Create a new animal object with the data from the database
				Location *store = [[Location alloc] initWithId:id city:city email:email image:image latitude:latitude longitude:longitude name:name phone:phone state:state streetAddress:streetAddress];
                
				// Add the animal object to the animals Array
				[stores addObject:store];
                NSLog(@"%@", [store name]);
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);
    */
    
    return stores;
}


-(NSArray *) readCityesFromDatabase {
	// Setup the database object
	sqlite3 *database;
    
	// Init the cityes Array
	NSMutableArray *cityes = [[NSMutableArray alloc] init];
    
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT DISTINCT city FROM stores ORDER BY city ASC";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                NSString * city = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                              
				// Add the animal object to the animals Array
				[cityes addObject:city];
                NSLog(@"%@", city);
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);
    
    return cityes;
}

-(NSNumber *) countRecordsFromDatabase {
	// Setup the database object
	sqlite3 *database;
    
	// Init the cityes Array
	NSNumber *count;
    
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT COUNT (id) FROM stores";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Read the data from the result row
            sqlite3_step(compiledStatement);
            count = [NSNumber numberWithInt:(int)sqlite3_column_int(compiledStatement, 0)];
            NSLog(@"Database has %@ records!", count);
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);
    
    return count;
}

-(void) clearDatabase {
        // Setup the database object
        sqlite3 *database;
        
        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK){
                sqlite3_stmt *statement = nil;
                NSString* sqlStatement = [NSString stringWithFormat:@"DELETE FROM stores"];
                NSLog(@"somestring: %@", sqlStatement);
                const char *sql = [sqlStatement cStringUsingEncoding:[NSString defaultCStringEncoding]];
                if(sqlite3_prepare_v2(database, sql, -1, &statement, NULL)!=SQLITE_OK)
                    NSAssert1(0,@"Error preparing statement",sqlite3_errmsg(database));
                while(sqlite3_step(statement) == SQLITE_DONE){}
                sqlite3_finalize(statement);
        }
        sqlite3_close(database);
}


@end
