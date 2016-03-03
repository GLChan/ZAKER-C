//
//  ZKRSubArticlesCell.h
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKRRootTypeItem;
@interface ZKRSubArticlesCell : UICollectionViewCell

@property (nonatomic, strong) ZKRRootTypeItem *item;
//@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (nonatomic, strong) NSArray *articlesArray;
@property (nonatomic, strong) NSString *topImageURL;
@end
