//
//  ViewController.h
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,assign) CGRect finalCellRect;

@end

