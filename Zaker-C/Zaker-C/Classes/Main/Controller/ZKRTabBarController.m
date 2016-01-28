//
//  ZKRTabBarController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/25.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRTabBarController.h"
#import "ZKRNavigationController.h"
#import "ZKRSubscriptionViewController.h"
#import "ZKRHotViewController.h"
#import "ZKRFunViewController.h"
#import "ZKRCommunityViewController.h"

@interface ZKRTabBarController ()

@end

@implementation ZKRTabBarController

+ (void)load
{
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //设置字体大小
    //设置字体大小的时候要设置在正常状态下的时候
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    
    //设置选中状态下的字体颜色
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSForegroundColorAttributeName] = ZKRRedColor;
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildViewController];
    
    [self setupAllTabBarButton];
}

- (void)setupAllChildViewController
{
    //订阅
    ZKRSubscriptionViewController *subscriptionVC = [[ZKRSubscriptionViewController alloc] init];
    ZKRNavigationController *nav = [[ZKRNavigationController alloc] initWithRootViewController:subscriptionVC];
    [self addChildViewController:nav];
    
    //热点
    ZKRHotViewController *hotVC = [[ZKRHotViewController alloc] init];
    ZKRNavigationController *nav1 = [[ZKRNavigationController alloc] initWithRootViewController:hotVC];
    [self addChildViewController:nav1];
    
    //玩乐
    ZKRFunViewController *funVC = [[ZKRFunViewController alloc] init];
    ZKRNavigationController *nav3 = [[ZKRNavigationController alloc] initWithRootViewController:funVC];
    [self addChildViewController:nav3];
    
    //社区
    ZKRCommunityViewController *communityVC = [[ZKRCommunityViewController alloc] init];
    ZKRNavigationController *nav4 = [[ZKRNavigationController alloc] initWithRootViewController:communityVC];
    [self addChildViewController:nav4];
}

- (void)setupAllTabBarButton
{
    //订阅
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"订阅";
    nav.tabBarItem.image = [UIImage imageWithOriginalRender:@"tabBar_dingYue"];
    nav.tabBarItem.selectedImage = [UIImage imageWithOriginalRender:@"tabBar_dingYue_click"];
    
    //热点
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"热点";
    nav1.tabBarItem.image = [UIImage imageWithOriginalRender:@"tabBar_hot"];
    nav1.tabBarItem.selectedImage = [UIImage imageWithOriginalRender:@"tabBar_hot_click"];
    
    //玩乐
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"玩乐";
    nav2.tabBarItem.image = [UIImage imageWithOriginalRender:@"tabBar_fun"];
    nav2.tabBarItem.selectedImage = [UIImage imageWithOriginalRender:@"tabBar_fun_click"];
    
    //社区
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"社区";
    nav3.tabBarItem.image = [UIImage imageWithOriginalRender:@"tabBar_sheQu"];
    nav3.tabBarItem.selectedImage = [UIImage imageWithOriginalRender:@"tabBar_sheQu_click"];
    
}
@end
