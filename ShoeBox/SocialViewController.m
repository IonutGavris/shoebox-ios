//
//  SocialViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "SocialViewController.h"
#import "MediaWebViewController.h"
#import "Constants.h"
#import "Helper.h"

@interface SocialViewController ()

@end

@implementation SocialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Social", @"Social");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)facebookButtonClicked:(id)sender
{
    MediaWebViewController *newView = [[MediaWebViewController alloc] initWithNibName:@"MediaWebViewController_iPhone" bundle:nil];
    [newView setWebsiteUrlStr:URL_FACEBOOK_PAGE];
    [self.navigationController pushViewController:newView animated:YES];

}

- (IBAction)twitterButtonClicked:(id)sender
{
    MediaWebViewController *newView = [[MediaWebViewController alloc] initWithNibName:@"MediaWebViewController_iPhone" bundle:nil];
    [newView setWebsiteUrlStr:URL_TWITTER_PAGE];
    [self.navigationController pushViewController:newView animated:YES];
}

@end
