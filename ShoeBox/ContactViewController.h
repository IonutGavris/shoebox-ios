//
//  FirstViewController.h
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController
{
    UITextField *textFieldName;
    UITextField *textFieldEmail;
    UITextField *textFieldPhone;
    UITextView *textFieldMessage;
}

@property (nonatomic, retain) IBOutlet UITextField *textFieldName;
@property (nonatomic, retain) IBOutlet UITextField *textFieldEmail;
@property (nonatomic, retain) IBOutlet UITextField *textFieldPhone;
@property (nonatomic, retain) IBOutlet UITextView *textFieldMessage;

- (IBAction)buttonSendPress:(id)sender;

@end
