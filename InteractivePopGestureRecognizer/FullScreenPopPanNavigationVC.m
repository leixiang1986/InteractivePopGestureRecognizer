//
//  FullScreenPopPanNavigationVC.m
//  InteractivePopGestureRecognizer
//
//  Created by 雷祥 on 2017/7/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "FullScreenPopPanNavigationVC.h"

@interface FullScreenPopPanNavigationVC ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@end

@implementation FullScreenPopPanNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.enabled = NO;
#warning handleNavigationTransition: 方法是通过打印 self.interactivePopGestureRecognizer.delegate获取的

    SEL selector = NSSelectorFromString(@"handleNavigationTransition:");
    NSLog(@"%@",self.interactivePopGestureRecognizer.delegate);
    //先获取系统设置的代理作为target
    if ([self.interactivePopGestureRecognizer.delegate respondsToSelector:selector]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:selector];
        pan.delegate = self;
        [self.view addGestureRecognizer:pan];
    }
    else {  //如果不能添加全屏的返回手势，就添加
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    //后设置代理
    self.interactivePopGestureRecognizer.delegate = self;
}






- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(backClick)];
        viewController.navigationItem.leftBarButtonItem = item;
    }

    [super pushViewController:viewController animated:animated];
}

- (void)backClick {
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.viewControllers.count > 1;
}

@end

