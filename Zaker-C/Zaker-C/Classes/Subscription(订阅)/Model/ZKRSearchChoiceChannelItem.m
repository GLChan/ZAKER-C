//
//  ZKRSearchChoiceChannelItem.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/4.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSearchChoiceChannelItem.h"
#import "MJExtension.h"

@implementation ZKRSearchChoiceChannelItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    
    return @{
             @"title" : @"block_info.title",
             @"stitle" : @"block_info.stitle",
             @"pic" : @"block_info.pic",
             @"large_pic" : @"block_info.large_pic",
             @"api_url" : @"block_info.api_url",
             @"data_type" : @"block_info.data_type",
             @"block_color" : @"block_info.block_color",
             
             };
}

@end
