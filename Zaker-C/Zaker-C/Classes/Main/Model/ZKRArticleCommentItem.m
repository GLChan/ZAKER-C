//
//  ZKRArticleCommentItem.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/7.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRArticleCommentItem.h"

#define CGLMargin 10
@implementation ZKRArticleCommentItem

- (CGFloat)cellHeight
{
    // 如果计算过了，就直接返回以前计算的值
    if (_cellHeight) return _cellHeight;
    
    // 文字的Y值
    _cellHeight += 70;
    
    // 文字
    CGFloat textMaxW = CGLScreenW - 80 - 20;
    CGSize textMaxSize = CGSizeMake(textMaxW, 200);
    _cellHeight += [self.content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + CGLMargin;
    
    // 中间内容
    
    
//    if () { // 如果包括回复

//    }
    
    return _cellHeight;
}
@end
