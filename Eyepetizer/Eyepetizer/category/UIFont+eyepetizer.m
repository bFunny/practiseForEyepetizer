//
//  UIFont+eyepetizer.m
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import "UIFont+eyepetizer.h"
/*
 FZLanTingHeiS-L-GB
 FZLanTingHeiS-DB1-GB
 Lobster 1.4
 */
@implementation UIFont (eyepetizer)

/**
 *  方正兰亭超长黑体
 */
+(UIFont *)FZSL_FontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"FZLanTingHeiS-L-GB" size:size];
}


/**
 *  方正兰亭加粗黑体
 */
+(UIFont *)FZSB_FontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"FZLanTingHeiS-DB1-GB" size:size];
}


/**
 *  艺术字体
 */
+(UIFont *)Lobster_FontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Lobster 1.4" size:size];
}

@end
