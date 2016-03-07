//
//  NSDate+Interval.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGLInterval : NSObject
@property (nonatomic, assign) NSInteger cgl_day NS_AVAILABLE_IOS(6_0);
/** 天 */
@property (nonatomic, assign) NSInteger day;
/** 小时 */
@property (nonatomic, assign) NSInteger hour;
/** 分钟 */
@property (nonatomic, assign) NSInteger minute;
/** 秒 */
@property (nonatomic, assign) NSInteger second;
@end

@interface NSDate (Interval)

- (CGLInterval *)cgl_intervalSinceDate:(NSDate *)date;
- (void)cgl_intervalSinceDate:(NSDate *)date day:(NSInteger *)dayP hour:(NSInteger *)hourP minute:(NSInteger *)minuteP second:(NSInteger *)secondP;
/**
 * 是否为今天
 */
- (BOOL)cgl_isInToday;

/**
 * 是否为昨天
 */
- (BOOL)cgl_isInYesterday;

/**
 * 是否为明天
 */
- (BOOL)cgl_isInTomorrow;

/**
 * 是否为今年
 */
- (BOOL)cgl_isInThisYear;
@end
