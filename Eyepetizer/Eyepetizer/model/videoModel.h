//
//  videoModel.h
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MJExtension.h"

@interface VideoModel : NSObject

@property (nonatomic,copy) NSString *videoId;
@property (nonatomic,copy) NSString *idx;
@property (nonatomic,copy) NSString *descr;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,strong) NSDictionary *provider;
@property (nonatomic,copy) NSString *playUrl;
@property (nonatomic,strong) NSDictionary *playInfo;
@property (nonatomic,strong) NSDictionary *consumption;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *coverForFeed;
@property (nonatomic,copy) NSString *coverForSharing;
@property (nonatomic,copy) NSString *coverBlurred;
@property (nonatomic,copy) NSString *duration;
@property (nonatomic,copy) NSString *webUrl;
@property (nonatomic,copy) NSString *rawWebUrl;
@property (nonatomic,copy) NSString *coverForDetail;

@end


