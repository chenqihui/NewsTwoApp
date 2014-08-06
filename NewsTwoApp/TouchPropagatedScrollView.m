//
//  TouchPropagatedScrollView.m
//
//  Created by Joel Chen on 8/6/14.
//  Copyright (c) 2014 Joel Chen [http://lnkd.in/bwwnBWR]
//

#import "TouchPropagatedScrollView.h"

@implementation TouchPropagatedScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
	return YES;
}

@end
