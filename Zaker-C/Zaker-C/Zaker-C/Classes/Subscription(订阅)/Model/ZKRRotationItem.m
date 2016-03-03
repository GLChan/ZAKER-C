//
//  ZKRRotationItem.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRRotationItem.h"
#import "MJExtension.h"

@implementation ZKRRotationItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"block_api_url" : @"block_info.api_url",
             @"topic_api_url" : @"topic.api_url",
             @"discussion_api_url" : @"discussion.api_url"
             
             };
}


@end
