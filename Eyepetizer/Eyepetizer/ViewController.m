//
//  ViewController.m
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import "ViewController.h"
#import "constant.h"
#import "HTTPHelper.h"
#import "FeedModel.h"
#import "DailyModel.h"
#import "WaterCell.h"
#import "WaterHeaderView.h"
#import "UIFont+eyepetizer.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface ViewController ()<CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource>
@property (nonatomic,strong) CHTCollectionViewWaterfallLayout *collectionLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void) loadData {
    
    [HTTPHelper GETURL:FEED_URL completionHandler:^(NSDictionary *result, NSError *error) {
        FeedModel *model = [FeedModel objectWithKeyValues:result];
        [self.dataArray addObject:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.dataArray.count > 0) {
               [self.collectionView reloadData];
            }
        });
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.dataArray = [NSMutableArray array];
    [self loadData];
}

- (void) viewWillAppear:(BOOL)animated {
    
}

- (void) viewDidAppear:(BOOL)animated {
    self.title = @"Eyepetizer";
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    FeedModel *model = self.dataArray[section];
    DailyModel *daily = [model.dailyList firstObject];
    return [daily.videoList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterCell" forIndexPath:indexPath];
    FeedModel *model = self.dataArray[indexPath.section];
    DailyModel *daily = [model.dailyList firstObject];
    cell.model = daily.videoList[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) / 1.6);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section {
    return 54.f;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    WaterHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"WaterHeaderView" forIndexPath:indexPath];
    return header;
}

- (CHTCollectionViewWaterfallLayout *)collectionLayout {
    if (!_collectionLayout) {
        _collectionLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
        _collectionLayout.columnCount = 1;
        _collectionLayout.minimumColumnSpacing = 0.0;
        _collectionLayout.minimumInteritemSpacing = 0.0;
    }
    return _collectionLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_collectionView registerClass:[WaterCell class] forCellWithReuseIdentifier:@"WaterCell"];
        [_collectionView registerClass:[WaterHeaderView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"WaterHeaderView"];
    }
    return _collectionView;
}

@end
