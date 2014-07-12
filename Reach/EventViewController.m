//
//  EventViewController.m
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import "EventViewController.h"
#import "EventCell.h"
#import "LiveEventViewController.h"
#import <Parse/Parse.h>
@implementation EventViewController{
    NSArray *monthAbbv;
    NSUInteger selectedIndex;
}

-(void)viewDidLoad{
    _events = [[NSMutableArray alloc] init];
    monthAbbv = @[@"JAN",@"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC"];
    [_eventTableView setDelegate:self];
    [_eventTableView setDataSource:self];
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            [_events addObjectsFromArray:objects];
            NSLog(@"Events: %@",[_events description]);
            [_eventTableView reloadData];
        }else{
            NSLog(@"Error: %@", [error description]);
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"ShowEvent" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    LiveEventViewController *vc = (LiveEventViewController *)[segue destinationViewController];
    PFObject *selectedEvent = [_events objectAtIndex:selectedIndex];
    vc.eventName = selectedEvent[@"description"];
    vc.eventId = [selectedEvent objectId];
    vc.recruiterId = _recruiterId;
    vc.company = _company;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_events count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EventCell *cell = [_eventTableView dequeueReusableCellWithIdentifier:@"Event"];
    NSDictionary *eventData = [_events objectAtIndex:indexPath.row];

    NSDate *eventDate = [eventData objectForKey:@"date"];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:eventDate];

    [cell.dayLabel setText:[NSString stringWithFormat:@"%ld",(long)[components day]]];
    [cell.monthLabel setText:[NSString stringWithFormat:@"%@", [monthAbbv objectAtIndex:[components month]]]];
    [cell.nameLabel setText:[eventData objectForKey:@"description"]];
    NSLog(@"Event Data: %@", [eventData description]);
    
    return cell;
}

@end
