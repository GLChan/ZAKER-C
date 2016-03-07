//
//  UIViewController+ZKRTop.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZKRTop <NSObject>

@optional
- (BOOL)zkr_ignoreStatusBar;

@end

@interface UIViewController (ZKRTop)<ZKRTop>

@end
