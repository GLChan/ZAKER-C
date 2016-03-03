//
//  NSObject+Object.h
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Object)
/* 获取对象的所有方法 */
-(void)getAllMethods;

/* 获取对象的所有属性 */
- (NSArray *)getAllProperties;

/* 获取对象的所有属性和属性内容 */
- (NSDictionary *)getAllPropertiesAndVaules;
@end
