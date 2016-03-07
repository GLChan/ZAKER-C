//
//  ZKRArticleCommentItem.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/7.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  评论模型
 */
@interface ZKRArticleCommentItem : NSObject

@property (nonatomic, strong) NSString *pk;
@property (nonatomic, strong) NSString *auther_pk;
@property (nonatomic, strong) NSString *auther_name;
@property (nonatomic, strong) NSString *auther_icon;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *like_num;
@property (nonatomic, strong) NSString *is_zakeruser;

@property (nonatomic, assign) CGFloat cellHeight;

@end
