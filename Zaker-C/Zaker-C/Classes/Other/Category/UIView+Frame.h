//
//  UIView+Frame.h
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat cgl_x;
@property CGFloat cgl_y;
@property CGFloat cgl_width;
@property CGFloat cgl_height;

@property CGFloat cgl_centerX;
@property CGFloat cgl_centerY;
- (BOOL)cgl_intersectWithView:(UIView *)view;
@end
