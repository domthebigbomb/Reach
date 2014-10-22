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
    _circleMask.layer.cornerRadius = _circleMask.layer.frame.size.width/2;
    _skills = [[NSArray alloc] initWithArray:[_userData objectForKey:@"skills"]];
    [_circleMask addSubview:_contactPicView];
    [_contactPicView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]]];
    NSString *fullName = [[NSString alloc] initWithFormat:@"%@ %@",[_userData objectForKey:@"firstName"],[_userData objectForKey:@"lastName"]];
    ;

    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:fullName];
    [[_navBar topItem] setTitle:fullName];
    //[_navBar pushNavigationItem:title animated:NO];
    //[_navBar pushNavigationItem: self.navigationItem animated:YES];
    //[_fullNameLabel setText:[NSString stringWithFormat:@"%@ %@",[_userData objectForKey:@"firstName"],[_userData objectForKey:@"lastName"]]];
    [_headlineLabel setText:[_userData objectForKey:@"headline"]];
    
    [_skillLabel setText:[NSString stringWithFormat:@"Skills: (%@)",[NSNumber numberWithInteger:[_skills count]]]];
    
    [_industryLabel setText:[NSString stringWithFormat:@"%@",[_userData objectForKey:@"industry"]]];
    [_summaryLabel setText:[NSString stringWithFormat:@"Description: %@",[_userData objectForKey:@"summary"]]];
    
    //Setup scrolling skills
    for(int i = 0; i < [_skills count]; i++){
        CGRect frame = CGRectMake((_skillScrollView.frame.size.width) * i, 0, _skillScrollView.frame.size.width, _skillScrollView.frame.size.height);
        
        UIView *skillView = [[UIView alloc] initWithFrame:frame];
        NSString *skill = [_skills objectAtIndex:i];
        UILabel *skillLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,_skillScrollView.frame.size.width, _skillScrollView.frame.size.height)];
        UIFont *font = [UIFont fontWithName:@"Helvetica Neue Light" size:18.0];
        [skillLabel setTextAlignment:NSTextAlignmentCenter];
        [skillLabel setTextColor:[UIColor darkGrayColor]];
        [skillLabel setFont:font];
        [skillLabel setText:skill];
        [skillView addSubview: skillLabel];
        [_skillScrollView addSubview:skillView];
        //[skillLabel sizeToFit];
    }
    
    [_skillScrollView setContentSize:CGSizeMake((_skillScrollView.frame.size.width) * [_skills count], _skillScrollView.frame.size.height)];
}

-(void)viewDidLayoutSubviews{
    [_summaryLabel sizeToFit];
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
    [_pingButon setBackgroundColor:[UIColor lightGrayColor]];
    [_pingButon setTitle:@"Ping Sent!" forState:UIControlStateNormal];
    [_pingButon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_pingButon setEnabled: NO];
    [self performSelector:@selector(resetPing) withObject:nil afterDelay:5.0f];
}

-(void)resetPing{
    [_pingButon setTitle:@"Ping" forState:UIControlStateNormal];
    [_pingButon setBackgroundColor:[UIColor whiteColor]];
    [_pingButon setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_pingButon setEnabled:YES];
    NSLog(@"Ping Reset");
}

-(IBAction)returnToList:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
