//
//  NSDate+Interval.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "NSDate+Interval.h"

@implementation CGLInterval

@end

@implementation NSDate (Interval)


- (CGLInterval *)cgl_intervalSinceDate:(NSDate *)date
{
    // 从date到self之间走过的秒数
    NSInteger interval = [self timeIntervalSinceDate:date];
    
    // 1分钟 = 60秒
    NSInteger secondsPerMinute = 60;
    
    // 1小时 = 60 * 60秒 = 3600秒
    NSInteger secondsPerHour = 60 * secondsPerMinute;
    
    // 1天 = 24 * 60  * 60秒
    NSInteger secondsPerDay = 24 * secondsPerHour;
    
    CGLInterval *intervalStruct = [[CGLInterval alloc] init];
    intervalStruct.day = interval / secondsPerDay;
    intervalStruct.hour = (interval % secondsPerDay) / secondsPerHour;
    intervalStruct.minute = ((interval % secondsPerDay) % secondsPerHour) / secondsPerMinute;
    intervalStruct.second = interval % secondsPerMinute;
    return intervalStruct;
}

- (void)cgl_intervalSinceDate:(NSDate *)date day:(NSInteger *)dayP hour:(NSInteger *)hourP minute:(NSInteger *)minuteP second:(NSInteger *)secondP
{
    // 从date到self之间走过的秒数
    NSInteger interval = [self timeIntervalSinceDate:date];
    
    // 1分钟 = 60秒
    NSInteger secondsPerMinute = 60;
    
    // 1小时 = 60 * 60秒 = 3600秒
    NSInteger secondsPerHour = 60 * secondsPerMinute;
    
    // 1天 = 24 * 60  * 60秒
    NSInteger secondsPerDay = 24 * secondsPerHour;
    
    *dayP = interval / secondsPerDay;
    *hourP = (interval % secondsPerDay) / secondsPerHour;
    *minuteP = ((interval % secondsPerDay) % secondsPerHour) / secondsPerMinute;
    *secondP = interval % secondsPerMinute;
}

- (BOOL)cgl_isInToday
{
    NSCalendar *calendar = [NSCalendar cgl_calendar];
    
    // 获得年月日
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *dateCmps = [calendar components:unit fromDate:[NSDate date]];
    
    return [selfCmps isEqual:dateCmps];
}

- (BOOL)cgl_isInThisYear
{
    NSCalendar *calendar = [NSCalendar cgl_calendar];
    
    // 获得年月日
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *dateCmps = [calendar components:unit fromDate:[NSDate date]];
    
    return [selfCmps isEqual:dateCmps];
}

- (BOOL)cgl_isInYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    // 获得只有年月日的字符串对象
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    // 获得只有年月日的日期对象
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    // 比较
    NSCalendar *calendar = [NSCalendar cgl_calendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (BOOL)cgl_isInTomorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    // 获得只有年月日的字符串对象
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    // 获得只有年月日的日期对象
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    // 比较
    NSCalendar *calendar = [NSCalendar cgl_calendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == - 1;
}
@end
