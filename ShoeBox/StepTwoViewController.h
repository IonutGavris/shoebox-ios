//
//  StepTwoViewController.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepTwoViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *theScroll;
}

-(IBAction)step3ButtonClicked:(id)sender;

@end
