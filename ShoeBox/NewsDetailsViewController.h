//
//  NewsDetailsViewController.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/12/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailsViewController : UIViewController
{
    IBOutlet UIWebView *webView;
}

@property (nonatomic, retain) NSString *articleTitle;
@property (nonatomic, retain) NSString *articleDescription;
@property (nonatomic, retain) NSString *articleUrl;

@end
