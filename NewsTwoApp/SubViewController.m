//
//  SubViewController.m
//  testMyBackNavigation
//
//  Created by chen on 14-3-25.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()
{
    UILabel *signalLabel;
    UISegmentedControl *selectTypeSegment;
}

@end

@implementation SubViewController

- (id)initWithFrame:(CGRect)frame andSignal:(NSString *)szSignal
{
    self = [super init];
    if (self)
    {
        self.szSignal = szSignal;
        self.view.frame = frame;
        self.title = szSignal;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.view.layer.borderWidth = 1;
        self.view.layer.borderColor = [UIColor blueColor].CGColor;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    signalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 90)];
    signalLabel.text = _szSignal;
    signalLabel.textAlignment = NSTextAlignmentCenter;
    signalLabel.contentMode = UIViewContentModeScaleAspectFill;
    [signalLabel setBackgroundColor:[UIColor clearColor]];
    [signalLabel setTextColor:[UIColor blackColor]];
    [signalLabel setFont:[UIFont systemFontOfSize:20]];
    signalLabel.center = self.view.center;
    [self.view addSubview:signalLabel];
    signalLabel.userInteractionEnabled = YES;
    signalLabel.layer.borderWidth = 1;
    signalLabel.layer.borderColor = [UIColor blueColor].CGColor;
    
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] init];
    singleTapRecognizer.numberOfTapsRequired = 1;
    [singleTapRecognizer addTarget:self action:@selector(pust2View:)];
    [signalLabel addGestureRecognizer:singleTapRecognizer];
}

- (void)setSzSignal:(NSString *)szSignal
{
    _szSignal = szSignal;
    signalLabel.text = szSignal;
}

- (void)pust2View:(id)sender
{
    SubViewController *subViewController = [[SubViewController alloc] initWithFrame:[UIScreen mainScreen].bounds andSignal:@""];
    [[QHMainGestureRecognizerViewController getMainGRViewCtrl] addViewController2Main:subViewController];
    NSArray *ar = [self.szSignal componentsSeparatedByString:@"--"];
    subViewController.szSignal = [NSString stringWithFormat:@"%@--%d", [ar objectAtIndex:0], subViewController.view.tag];
}

@end
