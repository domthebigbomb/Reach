//
//  UserDetailsViewController.m
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import "UserDetailsViewController.h"
#import <Parse/Parse.h>

@implementation UserDetailsViewController

-(void)viewDidLoad{
    [_contactPicView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]]];
    [_fullNameLabel setText:[NSString stringWithFormat:@"%@ %@",[_userData objectForKey:@"firstName"],[_userData objectForKey:@"lastName"]]];
    [_headlineLabel setText:[_userData objectForKey:@"headline"]];
    [_industryLabel setText:[_userData objectForKey:@"industry"]];
    [_summaryLabel setText:[_userData objectForKey:@"summary"]];
}

-(IBAction)addNotes:(id)sender{
    
}

-(IBAction)starProfile:(id)sender{
    if(_isStarred){
        _isStarred = NO;
        [_favoritedLabel setHidden:YES];
    }else{
        _isStarred = YES;
        [_favoritedLabel setHidden:NO];
    }
}

-(IBAction)finish:(id)sender{
    PFObject *review = [PFObject objectWithClassName:@"Review"];
    review[@"eventId"] = _eventId;
    review[@"studentId"] = _username;
    review[@"recruiterId"] = _recruiterId;
    review[@"isStarred"] =  [NSNumber numberWithBool:_isStarred];
    [review saveInBackground];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)pingUser:(id)sender{
    //PFInstallation *installation = [PFInstallation currentInstallation];
   
    //[installation saveInBackground];
    /*
    [[PFInstallation currentInstallation] setObject:[PFUser currentUser] forKey:@"user"];
    [[PFInstallation currentInstallation] saveEventually];

    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:@"objectId" equalTo:_username];
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"user" equalTo:userQuery];
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery];
    [push setMessage:@"Come by our booth, we'd love to talk!"];
    [push sendPushInBackground];
    */
    
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"Pings"];
    NSString *formattedMsg = [NSString stringWithFormat:@"Hi we're %@ and we'd love for you to visit our booth!", _company];
    [push setMessage:formattedMsg];
    [push sendPushInBackground];
    NSLog(@"Push sent!");
}

@end
