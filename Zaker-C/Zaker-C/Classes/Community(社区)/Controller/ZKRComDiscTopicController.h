//
//  ZKRComDiscTopicController.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/2.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKRCommentCellItem;
@interface ZKRComDiscTopicController : UITableViewController

@property (nonatomic, strong) ZKRCommentCellItem *item;

@property (nonatomic, strong) NSString *discussion_api_url;
@end
