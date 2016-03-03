//
//  ZKRCommentCellItem.h
//  zaaaa
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRCommentCellItem : NSObject

 /** 跳转请求链接 */
@property (nonatomic, strong) NSString *api_url;

@property (nonatomic, strong) NSString *large_pic;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *pk;
@property (nonatomic, strong) NSString *post_count;
@property (nonatomic, strong) NSString *subscribe_count;
 /** 小标题 */
@property (nonatomic, strong) NSString *stitle;
 /** 标题 */
@property (nonatomic, strong) NSString *title;


@end
