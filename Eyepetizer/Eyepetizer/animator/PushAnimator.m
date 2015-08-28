//
//  PushAnimator.m
//  Eyepetizer
//
//  Created by yilos on 15/8/28.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import "PushAnimator.h"
#import "WaterCell.h"
#import "MainViewController.h"
#import "FeedViewController.h"

@implementation PushAnimator

#pragma mark - 动画代理
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.36;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //  1.1  获得 fromVC 和 子 toVC
    MainViewController * fromVC = (MainViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FeedViewController * toVC = (FeedViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //  1.2  获得 容器 view
    //    ====================================
    //    暂时 理解为，转场动画的产生，是利用 一个容器 view 上，加 父VC 和 子 VC 的 view 去做动画 （执行完，移除）？？
    UIView * containerView = [transitionContext containerView];
    
    //  2、获取到点击的 cell
    fromVC.indexPath = [[fromVC.collectionView indexPathsForSelectedItems] firstObject]; //  记录一下
    WaterCell *cell =(WaterCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.indexPath];
    
    //    2.1、对Cell上的 imageView 截图 （iOS7 新增的 截图方法）
    UIView * snapShotView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    
    //    2.2 将 cell 上 图片的 frame 转换 给 截图的 view
    //      ====================================  （转换完，不用 add 上去 ？？）
    snapShotView.frame =  fromVC.finalCellRect = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    
    //    2.3 将原 cell 隐藏
    cell.imageView.hidden = YES;
    
    
    //  3、设置 第二个控制器（要出现的） 的位置、透明度先 设置为 0， 目标大图先隐藏
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    
    //    ----------------------- *************************** ————————————————————————————————
    
    //  4、把动画前后的两个ViewController加到容器中 (加的先后顺序  有 影响 ！！！！！！ )
    //      要把 to VC 加下边
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    //    ----------------------- *************************** ————————————————————————————————
    
    //  5、动起来。
    
    //    [self transitionDuration:transitionContext] 这个时间 要 和 usingSpringWithDamping 一致，或 更快
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        //    5.1、第二个控制器的透明度0~1；
        //        让截图的位置更新到 toVC 的 大图 所在位置后
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:toVC.imageView.frame fromView:toVC.view];
        
        
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
