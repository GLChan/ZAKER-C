//
//  ZKRChannelGroupItem.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  频道分组模型
 */
@class ZKRChannelItem;
@interface ZKRChannelGroupItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *is_end;
@property (nonatomic, strong) NSString *father_id;
@property (nonatomic, strong) NSString *list_icon;
@property (nonatomic, strong) NSArray *sons;
@property (nonatomic, strong) NSArray *channels;

@end
