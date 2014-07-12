//
//  UserTypeSelectViewController.m
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import "UserTypeSelectViewController.h"
#import "UserLoginViewController.h"

@implementation UserTypeSelectViewController
-(void) viewDidLoad{
    
}



- (IBAction)studentButtonPressed:(id)sender {
}

- (IBAction)recruiterButtonPressed:(id)sender {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UserLoginViewController *vc = (UserLoginViewController *)[segue destinationViewController];
    vc.user = _user;
    if([[segue identifier] isEqualToString:@"StudentLogin"]){
        vc.type = @2; //students
    }else{
        vc.type = @1; //recruiters
    }
}
@end
