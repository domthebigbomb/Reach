//
//  LiveEventViewController.m
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import "LiveEventViewController.h"
#import "StudentCell.h"
#import "LinkedInData.h"
#import "UserDetailsViewController.h"
#import <Parse/Parse.h>

@implementation LiveEventViewController{
    NSArray *students;
    NSMutableDictionary *studentImages;
    NSMutableArray *studentPicUrls;
    NSMutableArray *studentData;
    NSInteger selectedRow;
}

-(void)viewDidLoad{
    [_checkedInTableView setDelegate:self];
    [_checkedInTableView setDataSource:self];
    self.navigationItem.title = _eventName;
    studentPicUrls = [[NSMutableArray alloc] init];
    studentData = [[NSMutableArray alloc] init];
    studentImages = [[NSMutableDictionary alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"CheckIn"];
    [query whereKey:@"companyName" equalTo:_company];
    [query whereKey:@"eventId" equalTo:_eventId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            students = [[NSArray alloc] initWithArray:objects];
            for(NSDictionary *student in students){
                PFQuery *studentQuery = [PFUser query];
                //[query whereKey:@"linkedInData" equalTo:[PFObject objectWithClassName:@"LinkedInData"]];
                [studentQuery getObjectInBackgroundWithId:[student objectForKey:@"studentId"] block:^(PFObject *object, NSError *error) {
                    if(!error){
                        PFQuery *objectQuery = [PFQuery queryWithClassName:@"LinkedInData"];
                        PFObject *objectId = object[@"linkedInData"];
                        NSLog(@"%@",[objectId objectId]);
                        [studentData addObject:[objectQuery getObjectWithId:[objectId objectId]]];
                        /*
                        [objectQuery getObjectInBackgroundWithId: [objectId objectId] block:^(PFObject *student, NSError *error) {
                                NSLog(@"Student Info: %@",[student description]);
                            [studentPicUrls addObject:[student objectForKey:@"pictureUrl"]];
                        }];
                         */
                        [_checkedInTableView reloadData];
                    }
                }];
            }
            [_checkedInTableView reloadData];
        }else{
            NSLog(@"Error searching for checked in students");
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"ShowDetails" sender:self];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [studentData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentCell *cell = [_checkedInTableView dequeueReusableCellWithIdentifier:@"Student"];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",[[studentData objectAtIndex:indexPath.row] objectForKey:@"firstName"] ,[[studentData objectAtIndex:indexPath.row] objectForKey:@"lastName"]];
    [cell.nameLabel setText:fullName];
    [cell.contactPicView setImage:[UIImage imageNamed:@"fb_default.jpg"]];
    [cell.descriptionLabel setText:[[studentData objectAtIndex:indexPath.row] objectForKey:@"summary"]];
    NSString *studentPicURLString = [[studentData objectAtIndex:indexPath.row]  objectForKey:@"pictureUrl"];
    UIImage *contactImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: studentPicURLString]]];
    cell.circleMask.layer.cornerRadius = cell.circleMask.layer.frame.size.width/2;
    [cell.contactPicView setImage:contactImage];
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *contactImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: studentPicURLString]]];
        [cell.contactPicView setImage:contactImage];
    });
     */
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ShowPast"]){
        
    }else{
        UserDetailsViewController *vc = (UserDetailsViewController *)[segue destinationViewController];
        vc.username = [[students objectAtIndex:selectedRow] objectForKey:@"studentId"];
        vc.company = _company;
        vc.imageUrl = [[studentData objectAtIndex:selectedRow] objectForKey:@"pictureUrl"];
        vc.eventId = _eventId;
        vc.recruiterId = _recruiterId;
        vc.userData = [studentData objectAtIndex: selectedRow];
    }
}

-(IBAction)checkedIn:(id)sender{
    
}

-(IBAction)totalAttendents:(id)sender{
    
}

@end
