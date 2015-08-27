//
//  dailyModel.h
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface DailyModel : NSObject

@property (nonatomic,copy) NSString *date;
@property (nonatomic,assign) int total;
@property (nonatomic,strong) NSArray *videoList;

@end
