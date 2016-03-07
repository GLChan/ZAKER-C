//
//  ZKRCategoryButton.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRCategoryButton.h"
#import "ZKRFunCategoryItem.h"

#import "UIButton+WebCache.h"

@implementation ZKRCategoryButton
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.cgl_width;
    CGFloat height = self.cgl_height;
    
    self.titleLabel.center = CGPointMake(width * 0.5, height - 25);
    self.imageView.center = CGPointMake(width * 0.5, height * 0.5 - 15);
//    [self.imageView sizeToFit];
    self.imageView.cgl_width = 30;
    self.imageView.cgl_height = 30;
    
//    [self layoutIfNeeded];
}

- (void)setHighlighted:(BOOL)highlighted{}

- (void)setItem:(ZKRFunCategoryItem *)item
{
    _item = item;
    [self setTitle:item.category forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:item.icon] forState:UIControlStateNormal];
}




@end
