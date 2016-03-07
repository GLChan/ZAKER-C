//
//  ZKRRootTypeItem.h
//  Zaker-C
//
//  Created by GuangliChan on 16/1/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  collection 频道对象
 */
@interface ZKRRootTypeItem : NSObject


@property (nonatomic, strong) NSString *need_userinfo;
 /** block标题 */
@property (nonatomic, strong) NSString *block_title;
 /** block图标颜色 16进制 */
@property (nonatomic, strong) NSString *block_color;
 /** 跳转链接 */
@property (nonatomic, strong) NSString *api_url;
 /** 图标 */
@property (nonatomic, strong) NSString *pic;
 /** 标题 */
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pk;
@property (nonatomic, strong) NSString *is_end;
@property (nonatomic, strong) NSString *block_bg_key;
@property (nonatomic, strong) NSString *large_pic;

@end
