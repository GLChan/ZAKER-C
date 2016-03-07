//
//  NSString+Date.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

/**
 *  设置日期
 */
- (NSString *)setupCreatedAt
{
    NSString *afterTimeString = [NSString string];
    // 测试数据
    //    self.topic.created_at = @"2014-01-30 17:34:36";
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt dateFromString:self];
    
    if (createdAtDate.cgl_isInThisYear) { // 今年
        if (createdAtDate.cgl_isInYesterday) { // 昨天
            fmt.dateFormat = @"1天前";
            afterTimeString = [fmt stringFromDate:createdAtDate];
        } else if (createdAtDate.cgl_isInToday) { // 今天
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [[NSCalendar cgl_calendar] components:unit fromDate:createdAtDate toDate:[NSDate date] options:0];
            
            if (cmps.hour >= 1) { // 时间间隔 >= 1小时
                afterTimeString = [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间间隔 >= 1分钟
                afterTimeString = [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间间隔
                afterTimeString = @"刚刚";
            }
        } else { // 除昨天、今天以外，今年的其他天
            fmt.dateFormat = @"MM.dd";
            afterTimeString= [fmt stringFromDate:createdAtDate];
        }
    } else { // 非今年
        afterTimeString = @" ";
    }
    
    return afterTimeString;
}
@end
