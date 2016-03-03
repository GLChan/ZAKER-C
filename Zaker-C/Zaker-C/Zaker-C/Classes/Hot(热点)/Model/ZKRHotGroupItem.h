//
//  ZKRHotGroupItem.h
//  Zaker-C
//
//  Created by GuangliChan on 16/2/21.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRHotGroupItem : NSObject
//article_group

/** 标题 */
@property (nonatomic, strong) NSString *title;
/** logo (图片key:url) */
@property (nonatomic, strong) NSDictionary *logo;
/** api_url ([@"group"][@"api_url"])*/
@property (nonatomic, strong) NSDictionary *topic;


/** 模型数组(参数) */
@property (nonatomic, strong) NSMutableArray *items;

/** 模型数组(模型) */
@property (nonatomic, strong) NSMutableArray *cellItems;

@end
