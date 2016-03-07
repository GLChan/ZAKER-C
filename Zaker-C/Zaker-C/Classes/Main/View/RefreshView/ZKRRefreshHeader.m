//
//  ZKRRefreshHeader.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/28.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRRefreshHeader.h"

@interface ZKRRefreshHeader()

@end

@implementation ZKRRefreshHeader

/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    
    
    
    // 自动切换透明度
    self.automaticallyChangeAlpha = YES;
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 修改状态文字的颜色
    self.stateLabel.textColor = [UIColor grayColor];
    // 修改状态文字
    [self setTitle:@"下拉可以刷新..." forState:MJRefreshStateIdle];
    [self setTitle:@"松开即可刷新..." forState:MJRefreshStatePulling];
//    [self setTitle:@"正在玩命刷新中..." forState:MJRefreshStateRefreshing];

}

/**
 *  摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
    
}

@end
