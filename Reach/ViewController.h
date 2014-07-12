//
//  ViewController.h
//  Reach
//
//  Created by Dominic Ong on 7/11/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LIALinkedInHttpClient.h>
#import <LIALinkedInAuthorizationViewController.h>
#import <LIALinkedInApplication.h>
#import <AFHTTPRequestOperation.h>

@interface ViewController : UIViewController
- (IBAction)ConnectWithLinkedIn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *proceedButton;
@property (weak,nonatomic) IBOutlet UIButton *linkedInButton;
- (IBAction)ProceedToSignIn:(id)sender;
@end
