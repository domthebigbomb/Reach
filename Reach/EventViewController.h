//
//  EventViewController.h
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong) NSMutableArray *events;
@property (strong) NSString *company;
@property (strong) NSString *recruiterId;
@property (weak, nonatomic) IBOutlet UITableView *eventTableView;

@end
