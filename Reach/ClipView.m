//
//  ClipView.m
//  Reach
//
//  Created by Dominic Ong on 7/13/14.
//  Copyright (c) 2014 Linkedin. All rights reserved.
//

#import "ClipView.h"
#import "UserDetailsViewController.h"
@implementation ClipView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [self pointInside:point withEvent:event] ? _scrollView : nil;
}

@end
