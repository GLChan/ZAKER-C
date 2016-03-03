//
//  ZKRComDiscoverCell.h
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKRCommentCellItem;
@interface ZKRComDiscoverCell : UITableViewCell
@property (nonatomic, strong) ZKRCommentCellItem *item;

@property (nonatomic, strong) void(^addButtonClickBlock)();

@end
