//
//  ZKRTopViewController.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKRTopViewController : UIViewController
@property (nonatomic, copy) void (^statusBarClickBlock)();
/** 刚才显示出来的控制器 */
@property (nonatomic, weak) UIViewController *showingVc;
@end
