//
//  ZKRNavigationController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/25.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRNavigationController.h"
#import "UIBarButtonItem+CGLExtension.h"

@interface ZKRNavigationController ()

@end

@implementation ZKRNavigationController

+ (void)load
{
    //获取所有navigationBar
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    navigationBar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UINavigationBar appearance] setBarTintColor:ZKRRedColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"profile-header-back"] highImage:[UIImage imageNamed:@"profile-header-back"] title:nil addTarget:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
