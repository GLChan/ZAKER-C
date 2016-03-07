//
//  UIView+Frame.m

//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (BOOL)cgl_intersectWithView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    CGRect rect1 = [self convertRect:self.bounds toView:nil];
    CGRect rect2 = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(rect1, rect2);
}
 /** height */
- (CGFloat)cgl_height {
    return self.frame.size.height;
}

- (void)setCgl_height:(CGFloat)cgl_height {
    CGRect frame = self.frame;
    frame.size.height = cgl_height;
    self.frame = frame;
}

 /** width */
- (CGFloat)cgl_width {
     return self.frame.size.width;
}

- (void)setCgl_width:(CGFloat)cgl_width {
    CGRect frame = self.frame;
    frame.size.width = cgl_width;
    self.frame = frame;
}

 /** x */
- (void)setCgl_x:(CGFloat)cgl_x {
    CGRect frame = self.frame;
    frame.origin.x = cgl_x;
    self.frame = frame;

}
- (CGFloat)cgl_x {
    return self.frame.origin.x;
}

 /** y */
- (void)setCgl_y:(CGFloat)cgl_y {
    CGRect frame = self.frame;
    frame.origin.y = cgl_y;
    self.frame = frame;
}
- (CGFloat)cgl_y {
    return self.frame.origin.y;
}

 /** centerX */
- (void)setCgl_centerX:(CGFloat)cgl_centerX {
    CGPoint center = self.center;
    center.x = cgl_centerX;
    self.center = center;
}

- (CGFloat)cgl_centerX{
    return self.center.x;
}

/** centerY */
- (void)setCgl_centerY:(CGFloat)cgl_centerY {
    CGPoint center = self.center;
    center.y = cgl_centerY;
    self.center = center;
}

- (CGFloat)cgl_centerY{
    return self.center.y;
}
@end
