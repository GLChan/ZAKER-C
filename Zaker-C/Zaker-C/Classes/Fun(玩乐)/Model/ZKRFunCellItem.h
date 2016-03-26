//
//  ZKRFunCellItem.h
//  zaaaa
//
//  Created by GuangliChan on 16/2/19.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRFunCellItem : NSObject
 /** 文章字典(链接) */
@property (nonatomic, strong) NSDictionary *article;
@property (nonatomic, strong) NSString *click_stat_url;

 /** pic */ 
@property (nonatomic, strong) NSDictionary *pic;
@property (nonatomic, strong) NSString *pk;
@property (nonatomic, strong) NSString *type;


 /** 大标题 */
@property (nonatomic, strong) NSString *title;
 /** 小标题 */
@property (nonatomic, strong) NSString *content;


@end
