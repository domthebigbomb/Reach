//
//  LiveEventViewController.h
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveEventViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong) NSString *eventName;
@property (strong) NSString *company;
@property (strong) NSString *eventId;
@property (strong) NSString *recruiterId;
@property (weak, nonatomic) IBOutlet UITableView *checkedInTableView;
-(IBAction)totalAttendents:(id)sender;
-(IBAction)checkedIn:(id)sender;
@end
