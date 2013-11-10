//
//  LocationsDetailsViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "LocationsDetailsViewController.h"
#import "AppDelegateProtocol.h"
#import "AppDataObject.h"
#import "Location.h"
#import "MapViewController.h"
#import "Helper.h"

@interface LocationsDetailsViewController ()

@end

@implementation LocationsDetailsViewController
@synthesize tableViewDetails;
@synthesize locationManager = _locationManager;

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
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _locationManager = [[LocationManager alloc] initWithAccuracy:kCLLocationAccuracyBest];
    
    AppDataObject* theDataObject = [self theAppDataObject];
    
    if([theDataObject getSelectedLocation] != nil){
        Location *location = [theDataObject getSelectedLocation];
        self.title = location.details;
    } else {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_locationManager startUpdatingLocationForDelegate:self];
}

- (void) viewWillDisappear:(BOOL)animated{
    [_locationManager stopUpdatingLocationForDelegate:self];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0)
        return 3;
    else if (section == 1)
        return 1;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Location *location = [[self theAppDataObject] getSelectedLocation];
    
    if(indexPath.section == 0){
        
        switch (indexPath.row) {
            case 0:
                if(![location.phoneOne isEqualToString:@"(null)"]){
                    [cell.textLabel setText:location.phoneOne];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.tag = indexPath.row;
                } else {
                    [cell.textLabel setText:@"Telefon indisponibil"];
                    cell.userInteractionEnabled = false;
                }
                break;
            case 1:
                if(![location.phoneTwo isEqualToString:@"(null)"]){
                    [cell.textLabel setText:location.phoneTwo];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.tag = indexPath.row;
                } else {
                    [cell.textLabel setText:@""];
                    cell.userInteractionEnabled = false;
                }
                break;
            case 2:
                //we have position
                if(distance != 0){
                    NSString *dist = [NSString stringWithFormat:@"%lf",distance];
                    NSRange range = [dist rangeOfString:@"."];
                    NSMutableString *mutableDistance = [[NSMutableString alloc]init];
                    [mutableDistance appendString:@"Distanta "];
                    [mutableDistance appendString:[dist substringToIndex:range.location + 2]];
                    [mutableDistance appendString:@" km"];
                    [cell.textLabel setText:mutableDistance];
                }else{
                    [cell.textLabel setText:@"Se calculeaza..."];
                    cell.userInteractionEnabled = false;
                }
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        if(![location.latitude isEqualToString:@"(null)"] &&
           ![location.longitude isEqualToString:@"(null)"] &&
           ![[self theAppDataObject] isFromMap]){
            [cell.textLabel setText:@"Arata pe harta"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.tag = indexPath.row;
        } else {
            cell.hidden = true;
        }
    }
    
    //cell.backgroundColor = [UIColor colorWithRed:0 green:56.0/255 blue:150.0/255 alpha:1.0];
    [cell.textLabel setHighlightedTextColor:[UIColor whiteColor]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:0 green:56.0/255 blue:150.0/255 alpha:1.0]];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return @" ";
    }
    return nil;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    if (section == 0){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 18)];
        //label.text = [self theAppDataObject].store.streetAddress;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 2;
        [headerView addSubview:label];
    }
    return headerView;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    if(indexPath.section == 0 && indexPath.row == 0 && [tableView cellForRowAtIndexPath:indexPath].tag == 0){
        [Helper dialNumber:[[self theAppDataObject] getSelectedLocation].phoneOne];
    } else if(indexPath.section == 0 && indexPath.row == 1 && [tableView cellForRowAtIndexPath:indexPath].tag == 1){
        [Helper dialNumber:[[self theAppDataObject] getSelectedLocation].phoneTwo];
    } else if (indexPath.section == 1 && indexPath.row == 0 && [tableView cellForRowAtIndexPath:indexPath].tag == 0){
        //TODO: save store data in AppDataObject
        //implement stuff in mapviewcontroller
        //dont display this option if the store does not have
        //the location coordinates
        MapViewController *addController = [[MapViewController alloc]
                                            initWithNibName:@"MapViewController_iPhone" bundle:nil];
        [[self theAppDataObject] setFromDetails:YES];
        [[self navigationController] pushViewController:addController  animated:YES];
    }
}

- (void) locationReceived:(CLLocation *)location{
    [_locationManager stopUpdatingLocationForDelegate:self];
    
    distance = [Helper getDistanceWithStartLatitude:location.coordinate.latitude startLongitude:location.coordinate.longitude endLatitude:[[[self theAppDataObject] getSelectedLocation].latitude doubleValue] endLongitude:[[[self theAppDataObject] getSelectedLocation].longitude doubleValue]];
    
    UITableViewCell *cell = [[self tableViewDetails] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if(cell != nil){
        NSString *dist = [NSString stringWithFormat:@"%lf",distance];
        NSRange range = [dist rangeOfString:@"."];
        NSMutableString *mutableDistance = [[NSMutableString alloc]init];
        [mutableDistance appendString:@"Distanta "];
        [mutableDistance appendString:[dist substringToIndex:range.location + 2]];
        [mutableDistance appendString:@" km"];
        
        [cell.textLabel setText:mutableDistance];
    }
    
}

@end
