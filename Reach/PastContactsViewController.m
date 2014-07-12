//
//  PastContactsViewController.m
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import "PastContactsViewController.h"
#import "PastUserCell.h"
#import <Parse/Parse.h>
@implementation PastContactsViewController{
    NSMutableArray *starredStudents;
    NSMutableArray *regStudents;
}

-(void)viewDidLoad{
    starredStudents = [[NSMutableArray alloc] init];
    regStudents = [[NSMutableArray alloc] init];
    [_pastUsersTable setDelegate:self];
    [_pastUsersTable setDataSource:self];
    PFQuery *query = [PFQuery queryWithClassName:@"Review"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *reviews, NSError *error) {
        for(PFObject *review in reviews){
            if(review[@"isStarred"] == [NSNumber numberWithBool:YES]){
                [starredStudents addObject:review];
            }else{
                [regStudents addObject:review];
            }
        }
        [_pastUsersTable reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [starredStudents count] + [regStudents count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PastUserCell *cell = [_pastUsersTable dequeueReusableCellWithIdentifier:@"User"];
    if(indexPath.row >= [starredStudents count]){
        [cell.starLabel setHidden:YES];
        PFQuery *query = [PFUser query];
        [query whereKey:@"objectId" equalTo:[[regStudents objectAtIndex:indexPath.row-[starredStudents count]] objectForKey:@"studentId"]];
        [cell.nameLabel setText: [[[query findObjects] firstObject] objectForKey:@"username"]];
    }else{
        [cell.starLabel setHidden:NO];
        PFQuery *query = [PFUser query];
        NSString *studentId =[regStudents objectAtIndex:indexPath.row][@"studentId"];
        [query whereKey:@"objectId" equalTo: studentId];
        PFObject *user = [[query findObjects] firstObject];
        NSString *username = [user objectForKey:@"username"];
        [cell.nameLabel setText: username];
    }
    return cell;
}

-(IBAction)returnToLive:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
