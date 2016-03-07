//
//  UIViewController+ZKRTop.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "UIViewController+ZKRTop.h"
#import <objc/runtime.h>
#import "ZKRTopWindow.h"
#import "ZKRTopViewController.h"
@implementation UIViewController (ZKRTop)

+ (void)load
{
    Method m1 = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method m2 = class_getInstanceMethod(self, @selector(zkr_viewWillAppear:));
    method_exchangeImplementations(m1, m2);
}

- (void)zkr_viewWillAppear:(BOOL)animated
{
    [self zkr_viewWillAppear:animated];
    
    // 如果系统自动生成的控制器
    if ([NSStringFromClass(self.class) isEqualToString:@"UIInputWindowController"]) return;
    
    if ([self respondsToSelector:@selector(zkr_ignoreStatusBar)]) {
        if ([self zkr_ignoreStatusBar]) return;
    }
    
    ZKRTopViewController *topVc = (ZKRTopViewController *)[ZKRTopWindow sharedTopWindow].rootViewController;
    if (self == topVc) return;
    
    // 刷新状态栏
    topVc.showingVc = self;
    if (topVc.showingVc.preferredStatusBarUpdateAnimation == UIStatusBarAnimationNone) {
        [topVc setNeedsStatusBarAppearanceUpdate];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            [topVc setNeedsStatusBarAppearanceUpdate];
        }];
    }
}

@end
