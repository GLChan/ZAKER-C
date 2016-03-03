//
//  ZKRCategoryButton.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRCategoryButton.h"

@implementation ZKRCategoryButton
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.cgl_width;
    CGFloat height = self.cgl_height;
    
    self.titleLabel.center = CGPointMake(width * 0.5, height - 25);
    self.imageView.center = CGPointMake(width * 0.5, height * 0.5);
    self.imageView.backgroundColor = [UIColor cyanColor];
    
    [self layoutIfNeeded];
}

- (void)setHighlighted:(BOOL)highlighted{}

@end
