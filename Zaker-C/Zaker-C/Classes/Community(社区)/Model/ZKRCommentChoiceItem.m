//
//  ZKRCommentChoiceItem.m
//  zaaaa
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//
#import <objc/runtime.h>
#import "ZKRCommentChoiceItem.h"
#import "MJExtension.h"


#define CGLMargin 10

@implementation ZKRCommentChoiceItem

/**
 *  说明一下：模型属性名对应着字典中的哪个key
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"icon" : @"auther.icon",
             @"name" : @"auther.name",
             @"uid" : @"auther.uid",
             @"user_flag" : @"auther.user_flag[0].pic",
             @"is_official" : @"auther.is_official",
             
             @"discussion_info_url" : @"special_info.discussion_info_url",
             @"discussion_title" : @"special_info.discussion_title",
             @"medias_count" : @"special_info.medias_count",
             @"item_type" : @"special_info.item_type",
             
             @"m_url" : @"medias[0].m_url",
             @"medias_height" : @"medias[0].h",
             @"medias_weight" : @"medias[0].w",
             @"min_url" : @"medias[0].min_url",
             @"raw_url" : @"medias[0].raw_url",
             @"s_url" : @"medias[0].s_url",
             @"url" : @"medias[0].url",
             
             @"sec_min_url" : @"medias[1].url",
             @"thr_min_url" : @"medias[2].url",
             
             };
}

- (CGFloat)cellHeight
{
    // 如果计算过了，就直接返回以前计算的值
    if (_cellHeight) return _cellHeight;
    
    // 文字的Y值
    _cellHeight += 50;
    
    // 文字
    CGFloat textMaxW = CGLScreenW - 2 * CGLMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, 54);
    _cellHeight += [self.content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + CGLMargin;
//    _cellHeight += 54;
//    NSLog(@"%lf", [self.content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height);
    
    // 中间内容
    
    
    if (self.m_url) { // 如果不是纯文字帖子（不是段子）
        // 图片的真实宽度 self.width
        // 图片的真实高度 self.height
        // 图片显示出来的宽度
        CGFloat centerW = CGLScreenW;
        // 图片显示出来的高度
        
        CGFloat centerH = 0.0;
        if ([self.item_type intValue] == CGLItemTypeOne) {
            centerH = centerW * [self.medias_height intValue] / [self.medias_weight intValue];
        } else if ([self.item_type intValue] == CGLItemTypeTwo) {
            centerH = 183;
        } else if ([self.item_type intValue] == CGLItemTypeThree) {
            centerH = 123;
        }
        
        if (centerH > 300) {
            self.bigPicture = YES;
            centerH = 300;
        }
        
        CGFloat centerY = _cellHeight;
        // 图片显示出来的X
        CGFloat centerX = 0;
        self.centerFrame = CGRectMake(centerX, centerY, centerW, centerH);
        
        // 累加中间内容的高度
        _cellHeight += centerH;
        
        /*
         centerW    self.width
         -------  = -----------
         centerH    self.height
         */
    }
    
    // 工具条
    _cellHeight += 50 + CGLMargin;
    
    return _cellHeight;
}


/* 获取对象的所有属性和属性内容 */
- (NSDictionary *)getAllPropertiesAndVaules
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [props setObject:propertyValue forKey:propertyName];
        } else {
            [props setObject:@"_____" forKey:propertyName];
        }
        
    }
    free(properties);
    return props;
}

@end
