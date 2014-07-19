//
//  MainGestureRecognizerViewController.h
//  helloworld
//
//  Created by chen on 14/7/6.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MoveType)
{
    MoveTypeScale,
    moveTypeMove
};

@interface QHMainGestureRecognizerViewController : UIViewController

@property (nonatomic,assign) BOOL canDragBack;

@property (nonatomic,assign) MoveType moveType;

- (void)addViewController2Main:(UIViewController *)viewController;

+ (QHMainGestureRecognizerViewController *)getMainGRViewCtrl;

@end
