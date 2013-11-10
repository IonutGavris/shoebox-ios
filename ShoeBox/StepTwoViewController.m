//
//  StepTwoViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "StepTwoViewController.h"
#import "StepThreeViewController.h"

@interface StepTwoViewController ()

@end

@implementation StepTwoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Pasul 2", @"Pasul 2");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [theScroll setDelegate:self];
    [theScroll setScrollEnabled:YES];
    [theScroll setContentSize:CGSizeMake(320, 2300)];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)step3ButtonClicked:(id)sender
{
    StepThreeViewController *step1ViewController = [[StepThreeViewController alloc] initWithNibName:@"StepThreeViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:step1ViewController animated:YES];
}

@end
