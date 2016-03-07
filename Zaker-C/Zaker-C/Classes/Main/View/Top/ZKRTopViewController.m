//
//  ZKRTopViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRTopViewController.h"

@implementation ZKRTopViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.statusBarClickBlock) self.statusBarClickBlock();
}

#pragma mark - 状态栏控制
- (BOOL)prefersStatusBarHidden
{
    return self.showingVc.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.showingVc.preferredStatusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return self.showingVc.preferredStatusBarUpdateAnimation;
}
@end
