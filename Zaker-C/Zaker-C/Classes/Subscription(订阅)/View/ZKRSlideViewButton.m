//
//  ZKRSlideViewButton.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/18.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSlideViewButton.h"

@implementation ZKRSlideViewButton

- (void)layoutSubviews
{
//    UIImageView *imageView = self.imageView;
    [super layoutSubviews];
    
    CGFloat imageViewCenterX = self.cgl_width * 0.5;
    CGFloat imageViewCenterY = self.cgl_height * 0.5 - 15;
    self.imageView.center = CGPointMake(imageViewCenterX, imageViewCenterY);

    CGFloat titleViewCenterX = self.cgl_width * 0.5;
    CGFloat titleViewCenterY = self.cgl_height * 0.5 + 15;
    self.titleLabel.center = CGPointMake(titleViewCenterX, titleViewCenterY);
    
    [self layoutIfNeeded];
    
    [self setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateDisabled];
    
}

- (void)setHighlighted:(BOOL)highlighted{}

@end
