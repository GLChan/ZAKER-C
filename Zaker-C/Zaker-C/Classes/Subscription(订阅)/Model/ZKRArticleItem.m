//
//  ZKRArticleItem.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/1.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRArticleItem.h"

@implementation ZKRArticleItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"open_type" : @"special_info.open_type",
             @"icon_url" : @"special_info.icon_url",
             @"discussionTitle" : @"special_info.discussion.title",
             @"discussionApi_url" : @"special_info.discussion.api_url",
             
             };
}
@end
