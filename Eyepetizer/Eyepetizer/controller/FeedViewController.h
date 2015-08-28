//
//  FeedViewController.h
//  Eyepetizer
//
//  Created by yilos on 15/8/28.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedViewController : UIViewController<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>
@property (strong, nonatomic)UIImageView *imageView;
@property (copy,nonatomic)NSString *imgUrl;
@end
