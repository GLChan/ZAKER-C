//
//  ZKRArticleItem.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/1.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRArticleItem : NSObject
@property (nonatomic, strong) NSString *app_ids;
 /** 发布方名字 */
@property (nonatomic, strong) NSString *auther_name;
 /** 发表日期 */
@property (nonatomic, strong) NSString *date;
 /** 请求链接 */
@property (nonatomic, strong) NSString *full_url;
 /** 图片数量 */
@property (nonatomic, strong) NSString *media_count;
 /** pk */
@property (nonatomic, strong) NSString *pk;
@property (nonatomic, strong) NSString *thumbnail_mpic;
@property (nonatomic, strong) NSString *thumbnail_pic;
@property (nonatomic, strong) NSString *thumbnail_picsize;
 /** 新闻标题 */
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *title_line_break;
@property (nonatomic, strong) NSString *weburl;

 /** 标题背景颜色 */
@property (nonatomic, strong) NSString *block_color;

 /** 话题/分类(跳转类型) */
@property (nonatomic, strong) NSString *open_type;
@property (nonatomic, strong) NSString *icon_url;
@property (nonatomic, strong) NSString *discussionTitle;
@property (nonatomic, strong) NSString *discussionApi_url;



@end
