//
//  UIFont+eyepetizer.h
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 FZLanTingHeiS-L-GB
 FZLanTingHeiS-DB1-GB
 Lobster 1.4
 */

@interface UIFont (eyepetizer)

/**
 *  方正兰亭超长黑体
 */
+(UIFont *)FZSL_FontOfSize:(CGFloat)size;


/**
 *  方正兰亭加粗黑体
 */
+(UIFont *)FZSDB1_FontOfSize:(CGFloat)size;

/**
 *  艺术字体
 */
+(UIFont *)Lobster_FontOfSize:(CGFloat)size;

@end
