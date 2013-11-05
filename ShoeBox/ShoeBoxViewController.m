//
//  FirstViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "ShoeBoxViewController.h"
#import "StepsViewController.h"

@interface ShoeBoxViewController ()

@end

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

@end
