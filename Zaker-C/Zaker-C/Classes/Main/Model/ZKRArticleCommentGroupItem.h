//
//  ZKRArticleCommentGroupItem.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/7.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  评论组 ( 最热评论, 最新评论)
 */

@interface ZKRArticleCommentGroupItem : NSObject

 /** 标题(最热or最新) */
@property (nonatomic, strong) NSString *title;

 /** 评论列表 */
@property (nonatomic, strong) NSMutableArray *list;

@end
