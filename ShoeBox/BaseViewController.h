//
//  BaseViewController.h
//  ShoeBox
//
//  Created by Ionut Gavris on 11/11/13.
//  Copyright (c) 2013 Ionut Gavris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)leftPressed:(id)sender;
- (void)rightPressed:(id)sender;
- (void) playVideo:(bool)withControls;

@end
