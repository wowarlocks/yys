//
//  ViewController.m
//  yys
//
//  Created by xiong on 2017/1/2.
//  Copyright © 2017年 xiong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *make = [[NSBundle mainBundle] pathForResource:@"offerReward" ofType:@"plist"];
    NSDictionary *offerRewardDic = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:make]];
    NSLog(@"dic is %@", [offerRewardDic allKeys]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
