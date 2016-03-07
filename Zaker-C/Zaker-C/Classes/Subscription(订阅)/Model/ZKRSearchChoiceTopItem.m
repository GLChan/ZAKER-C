//
//  ZKRSearchChoiceTopItem.m
//  zaaaa
//
//  Created by GuangliChan on 16/2/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSearchChoiceTopItem.h"
#import "MJExtension.h"

@implementation ZKRSearchChoiceTopItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"api_url":@[@"block_info.api_url",@"block_topic.api_url"],
             
             };
}

@end
