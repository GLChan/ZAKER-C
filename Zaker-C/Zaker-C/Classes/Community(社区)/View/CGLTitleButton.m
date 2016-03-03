//
//  CGLTitleButton.m
//  BuDeJie
//
//  Created by GuangliChan on 16/1/30.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "CGLTitleButton.h"

@implementation CGLTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}


 /** 取消高亮状态 */
- (void)setHighlighted:(BOOL)highlighted{}
@end
