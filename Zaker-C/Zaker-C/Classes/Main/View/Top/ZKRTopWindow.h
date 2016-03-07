//
//  ZKRTopWindow.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKRTopWindow : UIWindow

+ (instancetype)sharedTopWindow;
/**
 *  显示顶层window
 *
 *  @param block 这个block会在状态栏区域被点击的时候调用
 */
+ (void)showWithStatusBarClickBlock:(void (^)())block;
@end
