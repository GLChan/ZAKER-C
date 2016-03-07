//
//  ZKRChannelItem.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  频道模型
 */
@interface ZKRChannelItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *block_title;
@property (nonatomic, strong) NSString *is_end;
@property (nonatomic, strong) NSString *block_color;
@property (nonatomic, strong) NSString *large_pic;
@property (nonatomic, strong) NSString *api_url;
@end
