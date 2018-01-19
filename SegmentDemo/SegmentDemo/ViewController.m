//
//  ViewController.m
//  SegmentDemo
//
//  Created by 张威 on 2018/1/19.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ViewController.h"
#import "SegmentView.h"
@interface ViewController ()<SegmentViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CustomSegment";
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, 45) withArray:@[@"测试一",@"测试二",@"测试三"]];
    segmentView.delegate = self;
    segmentView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:segmentView];
    
}

-(void)segmentValueChanged:(UISegmentedControl *)segment withClickAtIndex:(NSInteger)index
{
    NSLog(@"index=%ld",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
