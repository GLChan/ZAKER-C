//
//  ZKRSearchChoiceChannelItem.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/4.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRSearchChoiceChannelItem : NSObject

 /** 大标题 */
@property (nonatomic, strong) NSString *title;
 /** 小标题 */
@property (nonatomic, strong) NSString *stitle;
 /** 跳转链接 */
@property (nonatomic, strong) NSString *api_url;

 /** 图标颜色 */
@property (nonatomic, strong) NSString *block_color;
 /** 图片url */ 
@property (nonatomic, strong) NSString *large_pic;

 /** 跳转到不同控制器用 */
@property (nonatomic, strong) NSString *data_type;

@end
