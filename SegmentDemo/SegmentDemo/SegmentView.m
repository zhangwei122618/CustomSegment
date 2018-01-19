//
//  SegmentView.m
//  CRM
//
//  Created by Helloworld on 2017/7/6.
//  Copyright © 2017年 张威. All rights reserved.
//

#import "SegmentView.h"
#import "Masonry.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r /255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
@interface SegmentView ()

@property (nonatomic, strong)UISegmentedControl *segment;
@property (nonatomic, strong)UIImageView *sliderImageView;

@property (nonatomic, strong)UIView *lineBgView;
@property (nonatomic, assign)CGFloat left;
@property (nonatomic, assign)CGFloat width;

@end

@implementation SegmentView

// items 暂时只支持两个，后期根据需求再进行优化
- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // segment
        _segment = [[UISegmentedControl alloc] initWithItems:items];
        _segment.tintColor = [UIColor clearColor];
        _segment.backgroundColor = [UIColor whiteColor];
        _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
        NSDictionary *attribute = @{NSForegroundColorAttributeName:ColorWithRGB(39, 82, 252),NSFontAttributeName:[UIFont systemFontOfSize:15]};
        [_segment setTitleTextAttributes:attribute forState:UIControlStateSelected];
        
        NSDictionary *attribute1 = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
        [_segment setTitleTextAttributes:attribute1 forState:UIControlStateNormal];
        _segment.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:_segment];
        
        //_lineBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 41 * SCALETOWIDTH, SCREEN_WIDTH, 2)];
        _lineBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segment.frame) - 2, SCREEN_WIDTH, 2)];  //设计图规定蓝色线必须在底部，segment高度为45
        _lineBgView.backgroundColor = [UIColor clearColor];
        [_segment addSubview:_lineBgView];
        [_lineBgView addSubview:self.sliderImageView];
        _width = frame.size.width / items.count;
        _left = (_width - 60 ) / 2;
        [self.sliderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(_lineBgView).offset(_left);
            make.centerY.mas_equalTo(_lineBgView);
            make.size.mas_equalTo(CGSizeMake(60 , 2));
        }];
        
    }
    return self;
}
/**
 @brief 移动下面的滑块
 @ 返回空
 */
- (void)segmentValueChanged:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    _selectedItem = segment.selectedSegmentIndex;
    if (_delegate && [_delegate respondsToSelector:@selector(segmentValueChanged:withClickAtIndex:)]) {
        [_delegate segmentValueChanged:segment withClickAtIndex:index];
    }
    CGAffineTransform transform;
    switch (index) {
        case 0:
        {
            
            transform = CGAffineTransformIdentity;
        }
            break;
        case 1:
        {
            transform = CGAffineTransformMakeTranslation(_width, 0);
        }
            break;
        case 2:
        {
            transform = CGAffineTransformMakeTranslation(_width * 2, 0);
        }
            break;
        default:transform = CGAffineTransformIdentity;
            break;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.sliderImageView.transform = transform;
    }];
    
}

-(UIImageView *)sliderImageView
{
    if (!_sliderImageView) {
        _sliderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cust_slider"]];
        _sliderImageView.frame = CGRectMake(0, 0, 80, 2);
    }
    return _sliderImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
