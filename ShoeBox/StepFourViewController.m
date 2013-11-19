//
//  StepFourViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "StepFourViewController.h"

@interface StepFourViewController ()

@end

@implementation StepFourViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Pasul 4", @"Pasul 4");
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
        [theScroll setContentSize:CGSizeMake(320, 682)];
    }
    else
    {
        [theScroll setContentSize:CGSizeMake(320, 800)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
