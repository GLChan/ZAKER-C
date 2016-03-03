//
//  ZKRCollectionViewCell.h
//  Zaker-C
//
//  Created by GuangliChan on 16/1/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKRRootTypeItem;


@interface ZKRCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger channelIndex;

@property (nonatomic, strong) ZKRRootTypeItem *item;

@property (nonatomic, weak) UIImageView *ttickImageView;

@end
