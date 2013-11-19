//
//  StepThreeViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "StepThreeViewController.h"
#import "StepFourViewController.h"

@interface StepThreeViewController ()

@end

@implementation StepThreeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Pasul 3", @"Pasul 3");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [theScroll setDelegate:self];
    [theScroll setScrollEnabled:YES];
   
    if([[UIScreen mainScreen] bounds].size.height == 568.0f)//iphone 5
    {
         [theScroll setContentSize:CGSizeMake(320, 558)];
    }
    else
    {
         [theScroll setContentSize:CGSizeMake(320, 750)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pas4ButtonClicked:(id)sender
{
    StepFourViewController *step1ViewController = [[StepFourViewController alloc] initWithNibName:@"StepFourViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:step1ViewController animated:YES];
}

@end
