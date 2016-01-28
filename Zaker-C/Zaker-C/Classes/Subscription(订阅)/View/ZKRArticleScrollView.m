//
//  ZKRArticleScrollView.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#define CGLBUTTONWEITH  self.bounds.size.width//图片的宽度
#define CGLBUTTONHEIGHT  self.bounds.size.height//图片的高度
/**
 1. 定时滚动
 2. 将轮播和pageControl放在一个view里面(自定义一个view)
 3. pageControl的样式
 */
#import "ZKRArticleScrollView.h"
#import "ZKRRotationItem.h"
#import "ZKRScrollButton.h"

#import <UIButton+WebCache.h>

@interface ZKRArticleScrollView()<UIScrollViewDelegate>



@end

@implementation ZKRArticleScrollView

- (void)layoutSubviews
{
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
}

/** 根据模型初始化scrollView */
- (void)setupArticleWithItems:(NSArray *)items
{
    NSUInteger count = items.count;
    CGFloat y = 0;
    CGFloat w = CGLScreenW;
    CGFloat h = self.cgl_height;

    for (NSUInteger i = 0; i < count; i++) {
        ZKRRotationItem *item = items[i];
        ZKRScrollButton *button = [[ZKRScrollButton alloc] initWithFrame:CGRectMake(i * w, y, w, h)];
        [button setTitle:item.title forState:UIControlStateNormal];
        
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:item.promotion_img] forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:item.tag_info[@"image_url"]] forState:UIControlStateNormal];
        
        button.tag_type = item.tag_info[@"text"];
        
        self.contentSize = CGSizeMake(count * CGLScreenW, 0);
        
        [self addSubview:button];
    }

}



@end
