//
//  ZKRArticleContentItem.h
//  WebViewTest
//
//  Created by GuangliChan on 16/3/2.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  文章内容模型
 */
@interface ZKRArticleContentItem : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *content_format;
@property (nonatomic, strong) NSString *disclaimer;
@property (nonatomic, strong) NSArray *media;


@end
