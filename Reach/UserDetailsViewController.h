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
@property (strong) NSString *username;
@property (strong) NSString *company;
@property (strong) NSString *recruiterId;
@property (strong) NSString *eventId;
@property (strong) NSString *imageUrl;
@property BOOL isStarred;
@property (strong) NSDictionary *userData;
-(IBAction)addNotes:(id)sender;
-(IBAction)starProfile:(id)sender;
-(IBAction)finish:(id)sender;
-(IBAction)pingUser:(id)sender;
@end
