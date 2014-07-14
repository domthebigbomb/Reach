//
//  UserLoginViewController.h
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReachUser.h"
@interface UserLoginViewController : UIViewController<UIAlertViewDelegate>
@property (weak,nonatomic) IBOutlet UITextField *usernameField;
@property (weak,nonatomic) IBOutlet UITextField*passwordField;
@property (weak,nonatomic) IBOutlet UIButton *loginButton;
@property (weak,nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIView *loginViews;
@property NSNumber *type;
@property ReachUser *user;
-(void)hideKeyboard;
-(IBAction)loginButtonPressed:(id)sender;
-(IBAction)signupButtonPressed:(id)sender;
@end
