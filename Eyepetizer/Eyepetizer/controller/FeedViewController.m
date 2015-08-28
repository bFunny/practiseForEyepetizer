//
//  FeedViewController.m
//  Eyepetizer
//
//  Created by yilos on 15/8/28.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import "FeedViewController.h"
#import "MainViewController.h"
#import "PopAnimator.h"
#import "UIImageView+WebCache.h"

@implementation FeedViewController {
    
    UIPercentDrivenInteractiveTransition *_percentTransition;
}
- (instancetype) init {
    self = [super init];
    if (self) {
        self.title = @"Eyepetizer";
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];

    
    //自定义手势驱动
    UIScreenEdgePanGestureRecognizer * edgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(backPanGestureAction:)];
    //  指定滑动的 起始方向
    edgeGesture.edges = UIRectEdgeLeft;
    
    [self.view addGestureRecognizer:edgeGesture];
    
    UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
    butt.frame = CGRectMake(0, 0, 40, 40);
    [butt setTitle:@"pop" forState:UIControlStateNormal];
    [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:butt];
    self.navigationItem.leftBarButtonItem = left;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds)/1.6)];
        //_imageView.contentMode = UIViewContentModeScaleAspectFill;
        //_imageView.transform = CGAffineTransformMakeScale(1.24, 1.24);
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}


- (void)buttonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backPanGestureAction:(UIScreenEdgePanGestureRecognizer *)recognizer{
    
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.view].x / self.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间
    
    //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        _percentTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [_percentTransition updateInteractiveTransition:progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded)
    {
        //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        if (progress > 0.25) {
            [_percentTransition finishInteractiveTransition];
        }else{
            [_percentTransition cancelInteractiveTransition];
        }
        // 侧滑结束后，清空
        _percentTransition = nil;
    }
    
}

//  interaction For Dismissal 交互返回（eg：系统的左侧滑动返回） 时调用
//  哪个是  pan dismiss 时的方法
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    // 此处 代码执行PopAnimator
    if ([animationController isKindOfClass:[PopAnimator class]]) {
        return _percentTransition;
    }else{
        return nil;
    }
}

//toVC  pop 时 （ 点击返回按钮 ）时调用
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC
{
    
    if ([toVC isKindOfClass:[MainViewController class]]) {
        return [[PopAnimator alloc] init];
    }else{
        return nil;
    }
}

@end
