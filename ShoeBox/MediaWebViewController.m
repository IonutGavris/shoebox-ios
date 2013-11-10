//
//  MediaWebViewController.m
//  ShoeBox
//
//  Created by Florian Stanila on 11/7/13.
//  Copyright (c) 2013 Ionut Gavris. All rights reserved.
//

#import "MediaWebViewController.h"
#import "Constants.h"

@interface MediaWebViewController ()

@end

@implementation MediaWebViewController

@synthesize websiteUrlStr;

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
    NSURL *websiteUrl;
    websiteUrl = [NSURL URLWithString:websiteUrlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [theWebView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
