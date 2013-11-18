//
//  FirstViewController.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "BaseViewController.h"

@interface ShoeBoxViewController : BaseViewController

- (IBAction) joinButtonClicked:(id)sender;
- (IBAction) galleryButtonClicked:(id)sender;
- (IBAction) videoButtonClicked:(id)sender;

- (void) moviePlayBackDidFinish:(NSNotification*)notification;

@end
