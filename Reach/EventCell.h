//
//  EventCell.h
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@property (strong,nonatomic) NSString *eventName;
@property (strong,nonatomic) NSDate *date;

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
