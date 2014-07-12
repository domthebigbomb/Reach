//
//  PastContactsViewController.h
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PastContactsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *pastUsersTable;
-(IBAction)returnToLive:(id)sender;
@end
