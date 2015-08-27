//
//  WaterHeaderView.m
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import "WaterHeaderView.h"
#import "UIFont+eyepetizer.h"

@implementation WaterHeaderView {
    UILabel *dateLabel;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.font = [UIFont Lobster_FontOfSize:15];
        dateLabel.text = @"8月17号";
        [self addSubview:dateLabel];
    }
    return self;
}

@end
