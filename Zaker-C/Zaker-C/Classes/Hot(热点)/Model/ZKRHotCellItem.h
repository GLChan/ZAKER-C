//
//  ZKRHotCellItem.h
//  Zaker-C
//
//  Created by GuangliChan on 16/2/21.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRHotCellItem : NSObject

/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 图片 [0][@"url"]*/
@property (nonatomic, strong) NSArray *thumbnail_medias;
/** 作者,来源 */
@property (nonatomic, strong) NSString *auther_name;
/** 发表时间 */
@property (nonatomic, strong) NSString *date;
/** app内跳转链接 */
@property (nonatomic, strong) NSString *full_url;
/** 原文地址参数 (http: //iphone.myzaker.com/l.php?   l=56c8379d9490cb3e210000ff)*/
@property (nonatomic, strong) NSString *pk;
/** 原文地址 */
@property (nonatomic, strong) NSString *weburl;
 /** 图片标签 */
@property (nonatomic, strong) NSDictionary *special_info;
// /** 序列 */
//@property (nonatomic, strong) NSString *card_order;

/** 辨别组和cell */
@property (nonatomic, strong) NSString *type;


@end
