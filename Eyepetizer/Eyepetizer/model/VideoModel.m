//
//  videoModel.m
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"videoId":@"id",
             @"descr":@"description"};
}

@end
