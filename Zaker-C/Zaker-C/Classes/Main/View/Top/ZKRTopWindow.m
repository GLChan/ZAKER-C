//
//  ZKRTopWindow.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRTopWindow.h"
#import "ZKRTopViewController.h"

@implementation ZKRTopWindow


+ (void)showWithStatusBarClickBlock:(void (^)())block
{
    if (window_) return;
    
    [ZKRTopWindow sharedTopWindow].windowLevel = UIWindowLevelAlert;
    [ZKRTopWindow sharedTopWindow].backgroundColor = [UIColor clearColor];
    // 先显示window
    [ZKRTopWindow sharedTopWindow].hidden = NO;
    
    // 设置根控制器
    ZKRTopViewController *topVc = [[ZKRTopViewController alloc] init];
    topVc.view.backgroundColor = [UIColor clearColor];
    topVc.view.frame = [UIApplication sharedApplication].statusBarFrame;
    topVc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    topVc.statusBarClickBlock = block;
    [ZKRTopWindow sharedTopWindow].rootViewController = topVc;
}

/**
 *  当用户点击屏幕时，首先会调用这个方法，询问谁来处理这个点击事件
 *
 *  @return 如果返回nil，代表当前window不处理这个点击事件
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 如果触摸点的y值 > 20，当前window不处理
    if (point.y > 20) return nil;
    
    // 如果触摸点的y值 <= 20，按照默认做法处理
    return [super hitTest:point withEvent:event];
}

#pragma mark - 单例模式

static ZKRTopWindow *window_;

+ (instancetype)sharedTopWindow
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        window_ = [[self alloc] init];
    });
    return window_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        window_ = [super allocWithZone:zone];
    });
    return window_;
}

- (id)copyWithZone:(NSZone *)zone
{
    return window_;
}



@end
