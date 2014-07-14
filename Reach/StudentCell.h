//
//  StudentCell.h
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak,nonatomic) IBOutlet UIImageView *contactPicView;
@property (weak,nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *circleMask;
@end
