//
//  ZKRSubArticlesController.h
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKRRootTypeItem;
@interface ZKRSubArticlesController : UIViewController
@property (nonatomic, strong) ZKRRootTypeItem *item;

@property (nonatomic, strong) NSString *block_api_url;

@end
