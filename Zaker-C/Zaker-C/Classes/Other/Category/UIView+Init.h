//
//  UIView+Init.h
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Init)
+ (instancetype)cgl_viewFromXib;
/** 获取view 的view控制器 */
- (UINavigationController *)viewController;
/** 获取view 的nav控制器 */
- (UINavigationController *)navController;
@end
