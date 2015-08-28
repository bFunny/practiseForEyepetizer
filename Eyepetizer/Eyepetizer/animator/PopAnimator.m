//
//  PopAnimator.m
//  Eyepetizer
//
//  Created by yilos on 15/8/28.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import "PopAnimator.h"
#import "WaterCell.h"
#import "MainViewController.h"
#import "FeedViewController.h"

@implementation PopAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.36f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //  1.1  返回的时候，  fromVC 和 子 toVC 互换 了 (toVC 是当前VC)
    MainViewController * fromVC = (MainViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    FeedViewController * toVC = (FeedViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //  1.2  获得 容器 view
    UIView * containerView = [transitionContext containerView];
    
    //    2.1、大图  截图
    UIView * snapShotView = [toVC.imageView snapshotViewAfterScreenUpdates:NO];
    //    2.2 将 大图 的 frame 转换 给 截图的 view
    snapShotView.frame = [containerView convertRect:toVC.imageView.frame fromView:toVC.imageView.superview];
    //    2.3 将原 大图 隐藏
    toVC.imageView.hidden = YES;
    
    //  2、获取到点击的 cell，先隐藏cell 的 image
    //    fromVC.indexPath = [[fromVC.collectionView indexPathsForSelectedItems] firstObject]; //  之前记录过
    WaterCell *cell =(WaterCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.indexPath];
    cell.imageView.hidden = YES;
    
    //  3、设置 第二个控制器（要出现的） 的位置、透明度先 设置为 0， 目标 cell 图 先隐藏
    fromVC.view.frame = [transitionContext finalFrameForViewController:fromVC];
    
    
    //    ----------------------- *************************** ————————————————————————————————
    
    //  4、把动画前后的两个 VC 加到容器中 (加的先后顺序  有 影响 ！！！！！！ )
    //      要把 to VC 加下边
    [containerView addSubview:snapShotView];
    [containerView insertSubview:fromVC.view belowSubview:toVC.view];
    
    //    ----------------------- *************************** ————————————————————————————————
    
    //  5、动起来。
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        //  5.1、第二个控制器的透明度1~0；
        //  让截图的位置更新到 toVC 的 大图 所在位置后
        toVC.view.alpha = .0f;
        snapShotView.frame = fromVC.finalCellRect;  //  就是 cell 上 image 的frame
        
        
    } completion:^(BOOL finished) {
        
        //      5.2 截图覆盖上去后，大图 取消隐藏，截图移除
        //          原始的 cell上的图片 取消 隐藏
        cell.imageView.hidden = NO;
        [snapShotView removeFromSuperview];
        
        toVC.imageView.hidden = NO;
        
        //      5.3、告诉系统动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
    
}

@end
