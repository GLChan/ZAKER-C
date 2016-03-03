//
//  UIView+Init.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "UIView+Init.h"

@implementation UIView (Init)
+ (instancetype)cgl_viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


/** 获取view 的nav控制器 */
- (UINavigationController *)navController {
    
    /// Finds the view's view controller.
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    
    UIResponder *responder = self;
    
    while ((responder = [responder nextResponder]))
        
        if ([responder isKindOfClass: [UINavigationController class]])
            
            return (UINavigationController *)responder;
    
    
    
    // If the view controller isn't found, return nil.
    
    return nil;
    
}

/** 获取view 的nav控制器 */
- (UINavigationController *)viewController {
    
    /// Finds the view's view controller.
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    
    UIResponder *responder = self;
    
    while ((responder = [responder nextResponder]))
        
        if ([responder isKindOfClass: [UIViewController class]])
            
            return (UINavigationController *)responder;
    
    
    
    // If the view controller isn't found, return nil.
    
    return nil;
    
}
@end
