//
//  ReachUser.h
//  Reach
//
//  Created by Dominic Ong on 7/12/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReachUser : NSObject

@property (strong) NSString *accessToken;
@property (strong) NSString *email;
@property (strong) NSString *firstName;
@property (strong) NSString *lastName;
@property (strong) NSString *company;
@property (strong) NSString *companyId;
@property (strong) NSString *industry;
@property (strong) NSString *picUrlString;
@property (strong) NSString *summary;
@property (strong) NSString *headline;
@property (strong) NSArray *skills;
@property (strong) NSDictionary *data;
@end
