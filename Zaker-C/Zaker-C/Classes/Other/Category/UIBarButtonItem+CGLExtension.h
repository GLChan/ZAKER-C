//
//  UIBarButtonItem+CGLExtension.h
//  BuDeJie
//
//  Created by GuangliChan on 16/1/18.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CGLExtension)

+ (instancetype)itemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(NSString *)imageName selImage:(NSString *)selImageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage title:(NSString *)title addTarget:(id)target action:(SEL)action;
@end
