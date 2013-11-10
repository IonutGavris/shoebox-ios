//
//  StepsViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "StepsViewController.h"

@interface StepsViewController ()

@end

@implementation StepsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Ma implic", @"Ma implic");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)step1ButtonClicked:(id)sender
{
    StepOneViewController *step1ViewController = [[StepOneViewController alloc] initWithNibName:@"StepOneViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:step1ViewController animated:YES];
}

-(IBAction)step2ButtonClicked:(id)sender
{
    StepTwoViewController *step1ViewController = [[StepTwoViewController alloc] initWithNibName:@"StepTwoViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:step1ViewController animated:YES];
}

-(IBAction)step3ButtonClicked:(id)sender
{
    StepThreeViewController *step1ViewController = [[StepThreeViewController alloc] initWithNibName:@"StepThreeViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:step1ViewController animated:YES];
}

-(IBAction)step4ButtonClicked:(id)sender
{
    StepFourViewController *step1ViewController = [[StepFourViewController alloc] initWithNibName:@"StepFourViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:step1ViewController animated:YES];
}

@end
