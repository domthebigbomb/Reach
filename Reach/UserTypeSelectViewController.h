//
//  UserTypeSelectViewController.h
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReachUser.h"
@interface UserTypeSelectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *studentButton;
@property (weak, nonatomic) IBOutlet UIButton *recruiterButton;
- (IBAction)studentButtonPressed:(id)sender;
- (IBAction)recruiterButtonPressed:(id)sender;
@property (strong) ReachUser *user;
@end
