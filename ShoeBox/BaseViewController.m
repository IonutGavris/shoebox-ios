//
//  BaseViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 11/11/13.
//  Copyright (c) 2013 Ionut Gavris. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

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
    UIBarButtonItem *btnPlay = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(leftPressed:)];
    UIBarButtonItem *btnReload = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightPressed:)];
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = btnPlay;
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = btnReload;
    btnPlay.enabled=TRUE;
    btnReload.enabled=TRUE;
}

- (void)leftPressed:(id)sender
{
    [self playVideo:false];
}

- (void)rightPressed:(id)sender
{
    [Helper showSocialScreen:self];
}

- (void) playVideo:(bool)withControls
{
    NSString *thePath=[[NSBundle mainBundle] pathForResource:@"shoeboxintro" ofType:@"m4v"];
    NSURL *videoURL = [NSURL fileURLWithPath:thePath];
    
    MPMoviePlayerViewController *movieView_ = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
    [movieView_.view setContentMode:UIViewContentModeScaleAspectFill];
    [movieView_.moviePlayer setShouldAutoplay:NO];
    movieView_.moviePlayer.view.frame=self.view.frame;
    if(withControls) {
        [movieView_.moviePlayer setControlStyle:MPMovieControlStyleDefault];
    } else {
        [movieView_.moviePlayer setControlStyle:MPMovieControlStyleNone];
    }
    // Set the modal transition style of your choice
    [movieView_.moviePlayer setScalingMode:MPMovieScalingModeAspectFill];
    [movieView_.moviePlayer setMovieSourceType:MPMovieSourceTypeFile];
    [movieView_.moviePlayer prepareToPlay];
    [movieView_.moviePlayer play];
    [self presentViewController: movieView_ animated: NO completion: nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
