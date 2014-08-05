//
//  LeftViewController.m
//  WYApp
//
//  Created by chen on 14-7-17.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "LeftViewController.h"

#import "SliderViewController.h"
#import "SubViewController.h"

@interface LeftViewController ()
{
    NSArray *_arData;
}

@end

@implementation LeftViewController

- (void)viewDidLoad
{
    _arData = @[@"新闻", @"订阅", @"图片", @"视频", @"跟帖", @"电台"];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageBgV setImage:[UIImage imageNamed:@"sidebar_bg.jpg"]];
    [self.view addSubview:imageBgV];
    
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setFrame:CGRectMake(20, 40, 60, 30)];
    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [backbtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    
    UIButton *toNewViewbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toNewViewbtn setFrame:CGRectMake(CGRectGetMaxX(backbtn.frame) + 10, 40, 60, 30)];
    [toNewViewbtn setTitle:@"新页面" forState:UIControlStateNormal];
    [toNewViewbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [toNewViewbtn setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [toNewViewbtn addTarget:self action:@selector(toNewViewbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toNewViewbtn];
    
    __block float h = self.view.frame.size.height*0.7/[_arData count];
    __block float y = 0.15*self.view.frame.size.height;
    [_arData enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
    {
        UIView *listV = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, h)];
        [listV setBackgroundColor:[UIColor clearColor]];
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, listV.frame.size.width - 60, listV.frame.size.height)];
        [l setFont:[UIFont systemFontOfSize:20]];
        [l setTextColor:[UIColor whiteColor]];
        [l setBackgroundColor:[UIColor clearColor]];
        [l setText:obj];
        [listV addSubview:l];
        [self.view addSubview:listV];
        y += h;
    }];
}

- (void)backAction:(UIButton *)btn
{
    //下面是两种调用方式，其实原理是一样的，都是调用SliderViewController的接口closeSideBar
    //1
    [[SliderViewController sharedSliderController] closeSideBar];
    //2
//    [((SliderViewController *)[[[self.view superview] superview] nextResponder]) closeSideBar];
}

- (void)toNewViewbtn:(UIButton *)btn
{
    [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
    {
        SubViewController *subViewController = [[SubViewController alloc] initWithFrame:[UIScreen mainScreen].bounds andSignal:@""];
        [[QHMainGestureRecognizerViewController getMainGRViewCtrl] addViewController2Main:subViewController];
        subViewController.szSignal = @"新页面";
    }];
}

@end
