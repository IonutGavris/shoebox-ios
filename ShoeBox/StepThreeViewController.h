//
//  StepThreeViewController.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepThreeViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *theScroll;
}

-(IBAction)pas4ButtonClicked:(id)sender;

@end