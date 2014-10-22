//
//  UserDetailsViewController.h
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *contactPicView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *circleMask;
@property (weak, nonatomic) IBOutlet UILabel *skillLabel;
@property (weak, nonatomic) IBOutlet UIView *circleBorder;
@property (weak, nonatomic) IBOutlet UIScrollView *skillScrollView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIButton *pingButon;

@property (strong) NSString *username;
@property (strong) NSString *company;
@property (strong) NSString *recruiterId;
@property (strong) NSString *eventId;
@property (strong) NSString *imageUrl;
@property (strong) NSArray *skills;
@property BOOL isStarred;
@property (strong) NSDictionary *userData;
-(IBAction)addNotes:(id)sender;
-(IBAction)returnToList:(id)sender;
-(IBAction)starProfile:(id)sender;
-(IBAction)finish:(id)sender;
-(IBAction)pingUser:(id)sender;
@end
