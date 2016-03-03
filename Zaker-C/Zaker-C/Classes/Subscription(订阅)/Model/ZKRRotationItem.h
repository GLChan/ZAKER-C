//
//  ZKRRotationItem.h
//  Zaker-C
//
//  Created by GuangliChan on 16/1/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

 /** 轮播对象 */
@interface ZKRRotationItem : NSObject

@property (nonatomic, strong) NSString *pk;
 /** 图片URL */
@property (nonatomic, strong) NSString *promotion_img;
 /** 新闻标题 */
@property (nonatomic, strong) NSString *title;
 /** 新闻类型 */
@property (nonatomic, strong) NSString *type;
 /** 标签信息 */
@property (nonatomic, strong) NSDictionary *tag_info;

#pragma mark - ---| 频道 |---
@property (nonatomic, strong) NSString *block_api_url;

#pragma mark - ---| 专题/夜读 |---
@property (nonatomic, strong) NSString *topic_api_url;

#pragma mark - ---| 文章 |---

#pragma mark - ---| 讨论/话题 |---
@property (nonatomic, strong) NSString *discussion_api_url;


@end
