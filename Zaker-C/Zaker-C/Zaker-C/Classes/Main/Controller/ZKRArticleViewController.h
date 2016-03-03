//
//  ZKRArticleViewController.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/1.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKRArticleItem;
@interface ZKRArticleViewController : UIViewController

@property (nonatomic, strong) NSString *preVC;

@property (nonatomic, strong) ZKRArticleItem *item;

@end
