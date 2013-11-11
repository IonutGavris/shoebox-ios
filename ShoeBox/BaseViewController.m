//
//  BaseViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 11/11/13.
//  Copyright (c) 2013 Ionut Gavris. All rights reserved.
//

#import "BaseViewController.h"
#import "Helper.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *btnReload = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnReloadPressed:)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = btnReload;
    btnReload.enabled=TRUE;
}

- (void)btnReloadPressed:(id)sender
{
    [Helper showSocialScreen:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
