//
//  StepOneViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "StepOneViewController.h"
#import "StepTwoViewController.h"

@interface StepOneViewController ()

@end

@implementation StepOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Pasul 1", @"Pasul 1");
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
        [theScroll setContentSize:CGSizeMake(320, 530)];
    }
    else
    {
        [theScroll setContentSize:CGSizeMake(320, 630)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)step2ButtonClicked:(id)sender
{
    StepTwoViewController *step1ViewController = [[StepTwoViewController alloc] initWithNibName:@"StepTwoViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:step1ViewController animated:YES];
}

@end
