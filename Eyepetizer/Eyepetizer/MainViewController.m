//
//  ViewController.m
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import "MainViewController.h"
#import "constant.h"
#import "HTTPHelper.h"
#import "FeedModel.h"
#import "DailyModel.h"
#import "WaterCell.h"
#import "MJRefresh.h"
#import "WaterHeaderView.h"
#import "NSDate+DateTools.h"
#import "UIFont+eyepetizer.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "FeedViewController.h"
#import "PushAnimator.h"

@interface MainViewController ()<CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UINavigationControllerDelegate>
@property (nonatomic,strong) CHTCollectionViewWaterfallLayout *collectionLayout;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger currentDate;
@property (nonatomic) NSInteger currentMonth;

@end

@implementation MainViewController

- (void) loadData:(NSString *)urlString {
    
    [HTTPHelper GETURL:urlString completionHandler:^(NSDictionary *result, NSError *error) {
        FeedModel *model = [FeedModel objectWithKeyValues:result];
        [self.dataArray addObject:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView.footer endRefreshing];
            [self.collectionView reloadData];
        });
    }];
}

- (void) loadMore {
    NSDate *date = [NSDate dateWithString:[NSString stringWithFormat:@"%ld",self.currentDate] formatString:@"yyyyMMdd"];
    if ([date month] < self.currentMonth) {
        [self.collectionView reloadData];
        [self.collectionView.footer noticeNoMoreData];
        return;
    }
    self.currentDate -= 1;
    [self loadData:[NSString stringWithFormat:FEED_URL,self.currentDate]];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = @"Eyepetizer";
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    
    self.currentMonth = [date month];
    self.currentDate = [[date formattedDateWithFormat:@"yyyyMMdd"] integerValue];
    [self loadData:[NSString stringWithFormat:FEED_URL,self.currentDate]];
}

- (void) viewWillAppear:(BOOL)animated {
    
}

- (void) viewDidAppear:(BOOL)animated {
    self.navigationController.delegate = self;
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
    if (0 == section) {
        return 0.0;
    }
    return 54.f;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    WaterHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"WaterHeaderView" forIndexPath:indexPath];
    FeedModel *model = self.dataArray[indexPath.section];
    DailyModel *daily = [model.dailyList firstObject];
    header.date = daily.date;
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedViewController *vc = [[FeedViewController alloc] init];
    FeedModel *model = self.dataArray[indexPath.section];
    DailyModel *daily = [model.dailyList firstObject];
    VideoModel *video = daily.videoList[indexPath.row];
    vc.imgUrl = video.coverForFeed;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - transition

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if ([toVC isKindOfClass:[FeedViewController class]]) {
        PushAnimator *push = [[PushAnimator alloc] init];
        return push;
    }else{
        return nil;
    }
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
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        footer.appearencePercentTriggerAutoRefresh = -60;
        _collectionView.footer = footer;
    }
    return _collectionView;
}

@end
