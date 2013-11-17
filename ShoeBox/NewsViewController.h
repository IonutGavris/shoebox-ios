//
//  SecondViewController.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UITableViewController
{
    NSOperationQueue *_queue;
}

@property (retain) NSOperationQueue *queue;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
