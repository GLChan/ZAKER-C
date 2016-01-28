//
//  ZKRScrollButton.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRScrollButton.h"

@implementation ZKRScrollButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置滚动图片中的字体
    [self setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleShadowOffset:CGSizeMake(0, 0.5)];
    
    //设置label的位置
    self.titleLabel.frame = CGRectMake(10, self.cgl_height - self.titleLabel.cgl_height - 10, self.titleLabel.cgl_width, self.titleLabel.cgl_height);
    
    //根据判断tag的类型改变图片中小标签的位置
    if (![self.tag_type isEqualToString:@"广告"]) {
        self.imageView.frame = CGRectMake(self.cgl_width - self.imageView.cgl_width, 10, self.imageView.cgl_width, self.imageView.cgl_height);
    } else {
        self.imageView.frame = CGRectMake(0, self.cgl_height - self.imageView.cgl_height - 10, self.imageView.cgl_width, self.imageView.cgl_height);
    }
    
    [self layoutIfNeeded];
}

//取消按钮高亮
- (void)setHighlighted:(BOOL)highlighted{}
@end
