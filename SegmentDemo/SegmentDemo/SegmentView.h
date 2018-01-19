//
//  SegmentView.h
//  CRM
//
//  Created by Helloworld on 2017/7/6.
//  Copyright © 2017年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentViewDelegate <NSObject>

- (void)segmentValueChanged:(UISegmentedControl *)segment withClickAtIndex:(NSInteger)index;

@end

@interface SegmentView : UIView

@property (nonatomic, assign, readonly)NSInteger selectedItem;

@property (nonatomic, weak)id<SegmentViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)items;

@end
