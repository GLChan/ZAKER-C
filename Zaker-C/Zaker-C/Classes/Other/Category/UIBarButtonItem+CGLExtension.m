//
//  UIBarButtonItem+CGLExtension.m
//  BuDeJie
//
//  Created by GuangliChan on 16/1/18.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "UIBarButtonItem+CGLExtension.h"

@implementation UIBarButtonItem (CGLExtension)

 /** 设置导航条按钮(普通/高亮模式) */
+ (instancetype)itemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIView *buttonView = [[UIView alloc] initWithFrame:btn.bounds];
    [buttonView addSubview:btn];
    
    return [[self alloc] initWithCustomView:buttonView];
}

 /** 设置导航条按钮(普通/选中模式) */
+ (instancetype)itemWithImage:(NSString *)imageName selImage:(NSString *)selImageName target:(id)target action:(SEL)action
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIView *buttonView = [[UIView alloc] initWithFrame:btn.bounds];
    [buttonView addSubview:btn];
    
    return [[self alloc] initWithCustomView:buttonView];
}

 /** 导航条返回按钮 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage title:(NSString *)title addTarget:(id)target action:(SEL)action
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highImage forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [backButton setContentEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
@end
