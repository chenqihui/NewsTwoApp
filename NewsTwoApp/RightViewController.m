//
//  RightViewController.m
//  WYApp
//
//  Created by chen on 14-7-17.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "RightViewController.h"

@implementation RightViewController

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor clearColor]];
    UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageBgV setImage:[UIImage imageNamed:@"sidebar_bg.jpg"]];
    [self.view addSubview:imageBgV];
    imageBgV.userInteractionEnabled = YES;
    
    float y = 0.3*self.view.frame.size.height;
    // 头像
    _headImageView = [[UIImageView alloc] init];
    _headImageView.backgroundColor = [UIColor clearColor];
    _headImageView.frame = CGRectMake(self.view.center.x - 40*0.7, y, 100, 100);
    _headImageView.layer.cornerRadius = 50.0;
    _headImageView.layer.borderWidth = 1.0;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.image = [UIImage imageNamed:@"head1.jpg"];
    [imageBgV addSubview:_headImageView];
    _headImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] init];
    singleTapRecognizer.numberOfTapsRequired = 1;
    [singleTapRecognizer addTarget:self action:@selector(headPhotoAnimation)];
    [_headImageView addGestureRecognizer:singleTapRecognizer];
}

- (void)headPhotoAnimation
{
    [self rotate360WithDuration:2.0 repeatCount:1];
    _headImageView.animationDuration = 2.0;
    _headImageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"head1.jpg"],
                                      [UIImage imageNamed:@"head2.jpg"],[UIImage imageNamed:@"head2.jpg"],
                                      [UIImage imageNamed:@"head2.jpg"],[UIImage imageNamed:@"head2.jpg"],
                                      [UIImage imageNamed:@"head1.jpg"], nil];
    _headImageView.animationRepeatCount = 1;
    [_headImageView startAnimating];
}

- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount
{
	CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
	theAnimation.values = [NSArray arrayWithObjects:
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0,1,0)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2*M_PI, 0,1,0)],
						   nil];
	theAnimation.cumulative = YES;
	theAnimation.duration = aDuration;
	theAnimation.repeatCount = aRepeatCount;
	theAnimation.removedOnCompletion = YES;
    
	[_headImageView.layer addAnimation:theAnimation forKey:@"transform"];
}

@end
