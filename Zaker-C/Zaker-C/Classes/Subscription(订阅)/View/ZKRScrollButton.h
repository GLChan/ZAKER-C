//
//  ZKRScrollButton.h
//  Zaker-C
//
//  Created by GuangliChan on 16/1/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKRScrollButton : UIButton

 /** 每个模型的类型,用来区分广告和其他类别,广告类别的标签在左下角 */
@property (nonatomic, strong) NSString *tag_type;

@end
