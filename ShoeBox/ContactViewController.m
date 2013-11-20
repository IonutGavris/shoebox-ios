//
//  FirstViewController.m
//  ShoeBox
//
//  Created by Ionut Gavris on 12/11/12.
//  Copyright (c) 2012 Ionut Gavris. All rights reserved.
//

#import "ContactViewController.h"
#import "SKPSMTPMessage.h"
#import "Helper.h"

@interface ContactViewController () <SKPSMTPMessageDelegate>

@end

@implementation ContactViewController

@synthesize textFieldName;
@synthesize textFieldEmail;
@synthesize textFieldPhone;
@synthesize textFieldMessage;

SKPSMTPState HighestState;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Contact", @"Contact");
        self.tabBarItem.image = [UIImage imageNamed:@"contact"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if([Helper getOSVersion] >= 7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [theScroll setDelegate:self];
    [theScroll setScrollEnabled:YES];
    
    [theScroll setContentSize:CGSizeMake(320, 560)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == textFieldName) {
        [self.textFieldEmail becomeFirstResponder];
    } else if (theTextField == textFieldEmail) {
        [self.textFieldPhone becomeFirstResponder];
    } else if (theTextField == textFieldPhone) {
        [self.textFieldMessage becomeFirstResponder];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
}

- (IBAction)buttonSendPress:(id)sender
{
    if([[textFieldEmail text] length] > 0 ||
       [[textFieldPhone text] length] > 0) {
        
        NSMutableString *body = [[NSMutableString alloc] initWithString:@"Nume: "];
        [body appendString:[textFieldName text]];
        [body appendString:@"<br>Email: "];
        [body appendString:[textFieldEmail text]];
        [body appendString:@"<br>Telefon: "];
        [body appendString:[textFieldPhone text]];
        [body appendString:@"<br>Mesaj:<br><br>"];
        [body appendString:[textFieldMessage text]];
        
        [self sendMailFrom:[textFieldEmail text] to:@"valvesa@gmail.com" subject:@"Mesaj aplicatie ShoeBox iOS" body:body delegate:self];
    } else {
        //cere de la utilizator input pentru numar
        UIAlertView* dialog = [[UIAlertView alloc] init];
        [dialog setDelegate:self];
        [dialog setTitle:@"Atentie"];
        [dialog setMessage:@"Completati campurile din formularul de contact!"];
        [dialog addButtonWithTitle:NSLocalizedString(@"OK", @"")];
        
        [dialog show];
        [dialog release];
    }
}

- (void)sendMailFrom:(NSString *)from to:(NSString *)to subject:(NSString *)subject body:(NSString *) messageBody delegate:(NSObject <SKPSMTPMessageDelegate> *) delegate
{
    SKPSMTPMessage *test_smtp_message = [[SKPSMTPMessage alloc] init];
    test_smtp_message.fromEmail = from;
    test_smtp_message.toEmail = to;
    test_smtp_message.relayHost = @"smtp.gmail.com";
    test_smtp_message.requiresAuth = YES;
    test_smtp_message.login = @"appshoebox@gmail.com";
    test_smtp_message.pass = @"shoe2012";
    test_smtp_message.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
    test_smtp_message.subject = subject;
    //    test_smtp_message.bccEmail = @"testbcc@test.com";
    
    // Only do this for self-signed certs!
    // test_smtp_message.validateSSLChain = NO;
    test_smtp_message.delegate = delegate;
    
    NSMutableArray *parts_to_send = [NSMutableArray array];
    
    //If you are not sure how to format your message part, send an email to your self.
    //In Mail.app, View > Message> Raw Source to see the raw text that a standard email client will generate.
    //This should give you an idea of the proper format and options you need
    NSDictionary *plain_text_part = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"text/html; charset=ISO-8859-1", kSKPSMTPPartContentTypeKey,
                                     [messageBody stringByAppendingString:@"\n"], kSKPSMTPPartMessageKey,
                                     @"binary", kSKPSMTPPartContentTransferEncodingKey,
                                     nil];
    [parts_to_send addObject:plain_text_part];
    
    test_smtp_message.parts = parts_to_send;
    HighestState = 0;
    bool sent = [test_smtp_message send];
    
    if(sent)
        NSLog(@"Email SENT!");
    else
        NSLog(@"Email not sent!");
}

#pragma mark SKPSMTPMessage Delegate Methods
- (void)messageState:(SKPSMTPState)messageState;
{
    DEBUGLOG(@"HighestState:%d", HighestState);
    if (messageState > HighestState)
        HighestState = messageState;
}
- (void)messageSent:(SKPSMTPMessage *)SMTPmessage
{
    [SMTPmessage release];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Sent!"
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
    DEBUGLOG(@"email - message sent");
    [[self view] endEditing:YES];
}
- (void)messageFailed:(SKPSMTPMessage *)SMTPmessage error:(NSError *)error
{
    [SMTPmessage release];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription]
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
    DEBUGLOG(@"email - error(%d): %@", [error code], [error localizedDescription]);
    [[self view] endEditing:YES];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}

@end
