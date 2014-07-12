//
//  ViewController.m
//  Reach
//
//  Created by Dominic Ong on 7/11/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import "ViewController.h"
#import "ReachUser.h"
#import "UserTypeSelectViewController.h"
@interface ViewController ()

@end

@implementation ViewController{
    NSString *APIKey;
    NSString *SecretKey;
    LIALinkedInHttpClient *client;
    ReachUser *user;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    APIKey = @"75neykgf25j1hz";
    SecretKey = @"sbUz7sxgqvAZNxyU";
    
    client = [self linkedInApplication];
    

}

-(LIALinkedInHttpClient *)linkedInApplication{
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"http://www.google.com" clientId:APIKey clientSecret:SecretKey state:@"DCEEFWF45453sdffef424" grantedAccess:@[@"r_fullprofile",@"r_emailaddress"]];
    
    return [LIALinkedInHttpClient clientForApplication:application presentingViewController:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ConnectWithLinkedIn:(id)sender {
    [client getAuthorizationCode:^(NSString *code) {
        [client getAccessToken:code success:^(NSDictionary *accessTokenData) {
            NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
            [self requestMeWithToken:accessToken];
        } failure:^(NSError *error) {
            NSLog(@"Quering accessToken failed %@", error);
        }];
    } cancel:^{
        NSLog(@"Authorization was cancelled by user");
    } failure:^(NSError *error) {
        NSLog(@"Authorization failed %@", error);
    }];
}


- (void)requestMeWithToken:(NSString *)accessToken {
    NSLog(@"AccessToken:%@",accessToken);
    [client GET:[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(id,first-name,last-name,headline,industry,email-address,picture-url,summary,skills,positions)?oauth2_access_token=%@&format=json", accessToken] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
        NSLog(@"current user %@", result);
        user = [[ReachUser alloc] init];
        user.accessToken = accessToken;
        user.email = [result objectForKey:@"emailAddress"];
        user.firstName = [result objectForKey:@"firstName"];
        user.lastName = [result objectForKey: @"lastName"];
        user.industry = [result objectForKey:@"industry"];
        user.company = [[[[[result objectForKey:@"positions"] objectForKey:@"values"] firstObject] objectForKey:@"company"] objectForKey:@"name"];
        user.summary = [result objectForKey:@"summary"];
        user.picUrlString = [result objectForKey:@"pictureUrl"];
        user.skills = [[NSArray alloc] initWithArray:[[result objectForKey:@"skills"] objectForKey:@"values"]];
        user.headline = [result objectForKey:@"headline"];
        user.data = [[NSDictionary alloc] initWithDictionary:result];
        [_proceedButton setHidden:NO];
        [_linkedInButton setHidden:YES];
        }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed to fetch current user %@", error);
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UserTypeSelectViewController *vc = (UserTypeSelectViewController *)[segue destinationViewController];
    vc.user = user;
}
@end
