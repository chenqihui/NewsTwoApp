//
//  MainGestureRecognizerViewController.m
//  helloworld
//
//  Created by chen on 14/7/6.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHMainGestureRecognizerViewController.h"

@interface QHMainGestureRecognizerViewController ()<UIGestureRecognizerDelegate>
{
    CGPoint _startTouch;
    NSMutableArray *_arViewControllers;
    
    UIView *_blackMask;
    
    CGFloat startBackViewX;
}

@property (nonatomic,assign) BOOL isMoving;

@end

@implementation QHMainGestureRecognizerViewController

static QHMainGestureRecognizerViewController *mainGRViewCtrl;

- (void)viewDidLoad
{
//    [self.view setBackgroundColor:[UIColor grayColor]];
    if (!_arViewControllers)
    {
        _arViewControllers = [NSMutableArray new];
    }
    self.canDragBack = YES;
    _moveType = moveTypeMove;
    
    UIImageView *shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftside_shadow_bg"]];
    shadowImageView.frame = CGRectMake(-10, 0, 10, self.view.frame.size.height);
    [self.view addSubview:shadowImageView];
    
	// Do any additional setup after loading the view.
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    panGestureRecognizer.delegate = self;
    
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    mainGRViewCtrl = self;
}

- (void)addViewController2Main:(UIViewController *)viewController
{
    [self.view addSubview:viewController.view];
    [_arViewControllers addObject:viewController];
    viewController.view.tag = [_arViewControllers count];
    
    CGRect frame = viewController.view.frame;
    viewController.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, viewController.view.frame.origin.y, viewController.view.frame.size.width, viewController.view.frame.size.height);
    
    if (!_blackMask)
    {
        _blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        _blackMask.backgroundColor = [UIColor blackColor];
    }
    [_blackMask setAlpha:0.2];
    
    if ([_arViewControllers count] > 1)
    {
        UIViewController *backViewController = [_arViewControllers objectAtIndex:[_arViewControllers count] - 2];
        [backViewController.view addSubview:_blackMask];
    }
    [UIView animateWithDuration:0.6 animations:^
    {
        [viewController.view setFrame:frame];
        [_blackMask setAlpha:0.6];
    } completion:^(BOOL finished) {
        if ([_arViewControllers count] > 1)
        {
            UIViewController *backViewController = [_arViewControllers objectAtIndex:[_arViewControllers count] - 2];
            backViewController.view.alpha = 0;
        }
    }];
}

- (void)moveViewWithX:(float)x
{
    x = x>320?320:x;
    x = x<0?0:x;
    
    UIView *view = ((UIViewController *)[_arViewControllers lastObject]).view;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    view.frame = frame;
    
    float alpha = 0.4 - (x/800);
    _blackMask.alpha = alpha;
    
    switch (_moveType)
    {
        case MoveTypeScale:
            [self moveViewWithXTypeForScale:x];
            break;
        case moveTypeMove:
            [self moveViewWithXTypeForMove:x];
            break;
    }
}

- (void)moveViewWithXTypeForScale:(float)x
{
    float scale = (x/6400)+0.95;
    
    UIView *backView = ((UIViewController *)[_arViewControllers objectAtIndex:[_arViewControllers count] - 2]).view;
    backView.transform = CGAffineTransformMakeScale(scale, scale);
}

- (void)moveViewWithXTypeForMove:(float)x
{
    CGFloat aa = abs(startBackViewX)/[UIScreen mainScreen].bounds.size.width;
    CGFloat y = x*aa;
    
    UIView *backView = ((UIViewController *)[_arViewControllers objectAtIndex:[_arViewControllers count] - 2]).view;
    [backView setFrame:CGRectMake(startBackViewX + y,
                                  backView.bounds.origin.y,
                                  [UIScreen mainScreen].bounds.size.width,
                                  [UIScreen mainScreen].bounds.size.height)];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)recoginzer
{
    if (_arViewControllers.count <= 1 || !self.canDragBack) return;
    
    CGPoint touchPoint = [recoginzer locationInView:[[UIApplication sharedApplication] keyWindow]];
    
    if (recoginzer.state == UIGestureRecognizerStateBegan)
    {
        _isMoving = YES;
        _startTouch = touchPoint;
        CGRect frame = self.view.frame;
        if (!_blackMask)
        {
            _blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            _blackMask.backgroundColor = [UIColor blackColor];
        }
        
        UIView *backView = ((UIViewController *)[_arViewControllers objectAtIndex:[_arViewControllers count] - 2]).view;
        backView.alpha = 1;
        switch (_moveType)
        {
            case MoveTypeScale:
            {
                //                [backView addSubview:_blackMask];
                //                [backView setFrame:CGRectMake(0,
                //                                              backView.frame.origin.y,
                //                                              backView.frame.size.height,
                //                                              backView.frame.size.width)];
                break;
            }
            case moveTypeMove:
            {
                [backView addSubview:_blackMask];
                //起始位置
                startBackViewX = -200;
                [backView setFrame:CGRectMake(startBackViewX,
                                              backView.frame.origin.y,
                                              backView.frame.size.height,
                                              backView.frame.size.width)];
                break;
            }
        }
        
    }else if (recoginzer.state == UIGestureRecognizerStateEnded)
    {
        if (touchPoint.x - _startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                [_arViewControllers removeLastObject];
                [_blackMask removeFromSuperview];
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                [_blackMask removeFromSuperview];
            }];
            
        }
        return;
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            
            UIView *backView = ((UIViewController *)[_arViewControllers objectAtIndex:[_arViewControllers count] - 2]).view;
            backView.alpha = 0;
        }];
        
        return;
    }
    if (_isMoving)
        [self moveViewWithX:touchPoint.x - _startTouch.x];
}

+ (QHMainGestureRecognizerViewController *)getMainGRViewCtrl
{
    return mainGRViewCtrl;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

@end
