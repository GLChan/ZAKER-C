//
//  ZKRSubArticlesCell2.h
//  Zaker-C
//
//  Created by GuangliChan on 16/3/1.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKRRootTypeItem;
@interface ZKRSubArticlesCell2 : UICollectionViewCell
@property (nonatomic, strong) ZKRRootTypeItem *item;
//@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (nonatomic, strong) NSArray *articlesArray;
@property (nonatomic, strong) NSString *topImageURL;
@end
