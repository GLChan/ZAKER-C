//
//  ZKRCommentChoiceItem.h
//  zaaaa
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /** 全部 */
    CGLItemTypeOne = 1,
    /** 图片 */
    CGLItemTypeTwo = 2,
    /** 文字 */
    CGLItemTypeThree = 3,
    
    CGLItemTypeWord = 0
} CGLItemType;

@interface ZKRCommentChoiceItem : NSObject
 /** 头像url */
@property (nonatomic, strong) NSString *icon;
 /** 昵称 */
@property (nonatomic, strong) NSString *name;
 /** uid */
@property (nonatomic, strong) NSString *uid;
 /** 用户组(星标) */
@property (nonatomic, strong) NSString *user_flag;
 /** 是否官方账户 */
@property (nonatomic, strong) NSString *is_official;

 /** top时间(cell 该显示的时间) */
@property (nonatomic, strong) NSString *list_date;

/** 所属分类 (#数码脑残粉) */
@property (nonatomic, strong) NSString *discussion_title;
/** 所属分类url */
@property (nonatomic, strong) NSString *discussion_info_url;


 /** 发表内容 */
@property (nonatomic, strong) NSString *content;


 /** 点击次数 */
@property (nonatomic, strong) NSString *hot_num;
 /** 回复数量 */
@property (nonatomic, strong) NSString *comment_count;
 /** 点赞数 */
@property (nonatomic, strong) NSString *like_num;
 /** 是否点赞 */
@property (nonatomic, strong) NSString *is_liked;

#pragma mark - ---| 图片 |---
 /** 图片数目 */
@property (nonatomic, strong) NSString *medias_count;
 /** min_url */
@property (nonatomic, strong) NSString *min_url;
 /** s_url */
@property (nonatomic, strong) NSString *s_url;
 /** m_url */
@property (nonatomic, strong) NSString *m_url;
 /** raw_url */
@property (nonatomic, strong) NSString *raw_url;
 /** url */
@property (nonatomic, strong) NSString *url;
 /** height */
@property (nonatomic, strong) NSString *medias_height;
 /** weight */
@property (nonatomic, strong) NSString *medias_weight;
 /** cell显示几张图片 */
@property (nonatomic, strong) NSString *item_type;


 /** 第二张图片 */
@property (nonatomic, strong) NSString *sec_min_url;

@property (nonatomic, strong) NSString *thr_min_url;




#pragma mark - ---| 跳转后需要 |---
 /** 跳转之后显示的内容url */
@property (nonatomic, strong) NSString *content_url;
 /** 回复内容 */
@property (nonatomic, strong) NSString *comment_list_url;
/** 发表时间 */
@property (nonatomic, strong) NSString *date;

- (NSDictionary *)getAllPropertiesAndVaules;

#pragma mark - ---| 附加属性 |---
/** 通过这个模型计算出来的cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect centerFrame;
/** 是否为长图 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;


@end

