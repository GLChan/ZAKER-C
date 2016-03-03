//
//  ZKRFunGroupItem.h
//  zaaaa
//
//  Created by GuangliChan on 16/2/19.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRFunGroupItem : NSObject

@property (nonatomic, strong) NSDictionary *banner;

 /** 模型数组 */
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *pk;
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *show_more;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSMutableArray *itemsArray;
@end
