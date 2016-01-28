//
//  ZKRBarButtonItem.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRBarButtonItem.h"

@implementation ZKRBarButtonItem

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = 35;
    CGFloat height = self.cgl_height;
    
    NSMutableDictionary *attD = [NSMutableDictionary dictionary];
    attD[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    NSAttributedString *att = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:attD];
    
    self.titleLabel.attributedText = att;
    self.titleLabel.frame = CGRectMake(0, 0, width, height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.frame = CGRectMake(width, 0, self.cgl_width - width, height);
    
    [self layoutIfNeeded];
}

@end
