//
//  FeedModel.h
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface FeedModel : NSObject

@property (nonatomic,copy) NSString *nextPublishTime;
@property (nonatomic,strong) NSArray *dailyList;
@property (nonatomic,copy) NSString *nextPageUrl;

@end
