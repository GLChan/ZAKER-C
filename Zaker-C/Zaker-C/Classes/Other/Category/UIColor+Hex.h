//
//  UIColor+Hex.h
//
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CGLColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1];

#define CGLColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define CGLRandomColor CGLColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#define CGLGrayColor(v) CGLColor((v), (v), (v))
#define CGLCommonBgColor CGLGrayColor(240)

#define ZKRRedColor [UIColor colorWithRed:1 green:0.27 blue:0.26 alpha:1]

@interface UIColor (Hex)

// 默认alpha位1
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
