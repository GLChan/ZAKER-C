//
//  ZKRNavigationController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/25.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRNavigationController.h"
#import "UIBarButtonItem+CGLExtension.h"

@interface ZKRNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ZKRNavigationController

+ (void)load
{
    //获取所有navigationBar
    
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    // 设置不半透明
    navigationBar.translucent = NO;
    
//    // 设置导航条标题
//    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
//    titleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
//    [navigationBar setTitleTextAttributes:titleAttr];
    [[UINavigationBar appearance] setBarTintColor:ZKRRedColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 触发手势,就会调用Target的action
    id target = self.interactivePopGestureRecognizer.delegate;
    // target 监听pan手指的滑动, 然后会调用 handleNavigationTransition: 方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // 设置控制器为pan手势的代理,判断如果控制器栈中的控制器剩下最后一个的时候不能滑动
    pan.delegate = self;
    
    // 给view 添加pan手势
    [self.view addGestureRecognizer:pan];
    
    // 让原本系统的滑动不能用
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) {
        // 当控制器要加到栈顶的时候, 设置的一些内容
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"profile-header-back"] highImage:[UIImage imageNamed:@"profile-header-back"] title:nil addTarget:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
#pragma mark - UIGestureRecognizerDelegate
// 是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}
@end
