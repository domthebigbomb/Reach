//
//  UserLoginViewController.m
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import "UserLoginViewController.h"
#import <Parse/Parse.h>
#import "EventViewController.h"
#import "LinkedInData.h"

@implementation UserLoginViewController{
    UIAlertView *alert;
    UITapGestureRecognizer *tap;
    NSString *companyId;
    NSString *recruiter;
}

-(void)viewDidLoad{
    [_usernameField setText: [_user email]];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [tap setEnabled:YES];
    [self.view addGestureRecognizer:tap];
    _loginViews.layer.cornerRadius = 7.0f;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EventViewController *vc = (EventViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
    vc.company = _user.company;
    
    vc.recruiterId = recruiter;
}

-(IBAction)loginButtonPressed:(id)sender{
    [PFUser logInWithUsernameInBackground:[_usernameField text] password:[_passwordField text]
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSLog(@"Login Successful!");
                                            recruiter = [user objectId];
                                            [self performSegueWithIdentifier:@"ShowEvents" sender:self];
                                        } else {
                                            alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid Login Credentials" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                                        }
                                    }];
}

-(IBAction)signupButtonPressed:(id)sender{
    PFUser *user = [PFUser user];
    user.username = [_usernameField text];
    user.password = [_passwordField text];
    user.email = [_usernameField text];
    user[@"type"] = _type;
    user[@"accessToken"] = _user.accessToken;
    user[@"companyName"] = _user.company;
    PFQuery *query = [PFQuery queryWithClassName:@"Company"];
    [query whereKey:@"name" equalTo:_user.company];
    PFObject *result = [[query findObjects] firstObject];
    if(result == nil){
        PFObject *company = [PFObject objectWithClassName:@"Company"];
        company[@"name"] = _user.company;
        company[@"recruiterIds"] = @[];
        [company saveInBackground];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Company"];
        [query whereKey:@"name" equalTo:_user.company];
        PFObject *result = [[query findObjects] firstObject];
        user[@"companyId"] = [result objectId];
    }else{
        user[@"companyId"] = [result objectId];
    }
    PFObject *linkedInData = [PFObject objectWithClassName:@"LinkedInData"];
    linkedInData[@"firstName"] = _user.firstName;
    linkedInData[@"lastName"] = _user.lastName;
    linkedInData[@"email"] = _user.email;
    linkedInData[@"companyName"] = _user.company;
    linkedInData[@"summary"] = _user.summary;
    linkedInData[@"industry"] = _user.industry;
    linkedInData[@"headline"] = _user.headline;
    linkedInData[@"pictureUrl"] = _user.picUrlString;
    NSMutableArray *skills = [[NSMutableArray alloc] init];
    for(NSDictionary *skill in [_user skills]){
        [skills addObject:[[skill objectForKey:@"skill"] objectForKey:@"name"]];
    }
    linkedInData[@"skills"] = skills;
    [linkedInData saveInBackground];
    user[@"linkedInData"] = linkedInData;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Signup Successful");
            [self loginButtonPressed:self];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        }
    }];
}

-(void)hideKeyboard{
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    
}

@end
