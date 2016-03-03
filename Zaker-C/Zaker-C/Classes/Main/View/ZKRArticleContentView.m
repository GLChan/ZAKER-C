//
//  ZKRArticleContentView.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/2.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRArticleContentView.h"
#import "ZKRArticleItem.h"

@interface ZKRArticleContentView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *topView;
@end

@implementation ZKRArticleContentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupTopTitleView];
    
}



- (void)setupTopTitleView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 100)];
    topView.backgroundColor = [UIColor colorWithHexString:self.item.block_color];
    self.topView = topView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.cgl_x = 10;
    titleLabel.cgl_y = topView.cgl_height * 0.5 - 10;
    titleLabel.text = self.item.title;

    self.titleLabel = titleLabel;
    [self.topView addSubview:titleLabel];
    
    [self addSubview:self.topView];
}

@end
