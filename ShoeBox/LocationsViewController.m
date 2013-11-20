//
//  FirstViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "LocationsViewController.h"
#import "AppDelegateProtocol.h"
#import "AppDataObject.h"
#import "Location.h"
#import "Helper.h"

@interface LocationsViewController ()

@end

@implementation LocationsViewController

- (AppDataObject*) theAppDataObject;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	AppDataObject* theDataObject;
	theDataObject = (AppDataObject*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Locatii", @"Locatii");
        self.tabBarItem.image = [UIImage imageNamed:@"locatii"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self theAppDataObject].getLocations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Location *location = [[self theAppDataObject].getLocations objectAtIndex:indexPath.row];
    [cell.textLabel setText:location.city];
    [cell.detailTextLabel setText:location.streetAddress];
    [cell.imageView setImage:[UIImage imageNamed:@"map"]];
    [cell.textLabel setHighlightedTextColor:[UIColor whiteColor]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:0 green:124.0/255 blue:255.0/255 alpha:1.0]];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Location *location = [[self theAppDataObject].getLocations objectAtIndex:indexPath.row];
    [Helper showLocationDetailScreen:self withLocation:location fromMap:false];
}

@end
