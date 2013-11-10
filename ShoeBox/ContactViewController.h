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
    UIButton *buttonSend;
    UITextField *textFieldName;
    UITextField *textFieldEmail;
    UITextField *textFieldPhone;
    UITextField *textFieldMessage;
}

@property (nonatomic, retain) IBOutlet UIButton *buttonSend;
@property (nonatomic, retain) IBOutlet UITextField *textFieldName;
@property (nonatomic, retain) IBOutlet UITextField *textFieldEmail;
@property (nonatomic, retain) IBOutlet UITextField *textFieldPhone;
@property (nonatomic, retain) IBOutlet UITextField *textFieldMessage;

- (IBAction)buttonSendPress:(id)sender;

@end
