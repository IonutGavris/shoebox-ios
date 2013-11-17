//
//  FirstViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "ShoeBoxViewController.h"
#import "StepsViewController.h"
#import "Constants.h"
#import "Helper.h"
#import "MediaWebViewController.h"

@implementation ShoeBoxViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"ShoeBox", @"ShoeBox");
        self.tabBarItem.image = [UIImage imageNamed:@"gift"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if([Helper getOSVersion] >= 7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) joinButtonClicked:(id)sender
{
    StepsViewController *stepsViewController = [[StepsViewController alloc] initWithNibName:@"StepsViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:stepsViewController animated:YES];
}

- (IBAction) galleryButtonClicked:(id)sender
{
    MediaWebViewController *newView = [[MediaWebViewController alloc] initWithNibName:@"MediaWebViewController_iPhone" bundle:nil];
    [newView setWebsiteUrlStr:URL_FACEBOOK_ALBUM];
    [self.navigationController pushViewController:newView animated:YES];
}

- (IBAction) videoButtonClicked:(id)sender
{
    MediaWebViewController *newView = [[MediaWebViewController alloc] initWithNibName:@"MediaWebViewController_iPhone" bundle:nil];
     [newView setWebsiteUrlStr:URL_YOUTUBE_CHANNEL];
    [self.navigationController pushViewController:newView animated:YES];
}

@end
