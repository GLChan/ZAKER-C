//
//  ZKRSearchChoiceTopItem.h
//  zaaaa
//
//  Created by GuangliChan on 16/2/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRSearchChoiceTopItem : NSObject

@property (nonatomic, strong) NSString *ads_stat_url;
 /** api_url */
@property (nonatomic, strong) NSDictionary *block_info;
@property (nonatomic, strong) NSDictionary *block_topic;
@property (nonatomic, strong) NSString *api_url;


 /** pic url */
@property (nonatomic, strong) NSString *promotion_img;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;

@end
