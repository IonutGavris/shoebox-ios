//
//  NewsDetailsViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "NewsDetailsViewController.h"

@interface NewsDetailsViewController ()

@end

@implementation NewsDetailsViewController

@synthesize articleDescription, articleTitle, articleUrl;

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
    // Do any additional setup after loading the view from its nib.
    if(articleTitle != nil && [articleTitle length] > 0)
    {
        [txtTitle setText:articleTitle];
    }
    if(articleDescription != nil && [articleDescription length] > 0)
    {
        [webView loadHTMLString:articleDescription baseURL:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
