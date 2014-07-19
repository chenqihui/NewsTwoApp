//
//  LeftViewController.m
//  WYApp
//
//  Created by chen on 14-7-17.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "LeftViewController.h"

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

@end
