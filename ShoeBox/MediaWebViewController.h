//
//  MediaWebViewController.h
//  ShoeBox
//
//  Created by Florian Stanila on 11/7/13.
//  Copyright (c) 2013 Ionut Gavris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaWebViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *theWebView;
}

@property (nonatomic, retain) NSString *websiteUrlStr;

@end
