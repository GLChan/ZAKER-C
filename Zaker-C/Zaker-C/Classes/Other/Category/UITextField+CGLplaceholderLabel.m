//
//  UITextField+CGLplaceholderLabel.m
//  BuDeJie
//
//  Created by GuangliChan on 16/1/22.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "UITextField+CGLplaceholderLabel.h"
#import <objc/message.h>
@implementation UITextField (CGLplaceholderLabel)

/** 利用runtime给系统的类添加属性; 自定义方法与系统的方法交换 */

+ (void)load
{
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method cgl_setPlaceholderMethod = class_getInstanceMethod(self, @selector(cgl_setPlaceholder:));
    method_exchangeImplementations(setPlaceholderMethod, cgl_setPlaceholderMethod);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

- (void)cgl_setPlaceholder:(NSString *)placeholder
{
    [self cgl_setPlaceholder:placeholder];
    
    self.placeholderColor = self.placeholderColor;
}
@end
