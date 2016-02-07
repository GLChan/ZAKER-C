//
//  ZKRCollectionViewCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRCollectionViewCell.h"
#import "ZKRRootTypeItem.h"
#import <UIButton+WebCache.h>
//#import <UIImageView+WebCache.h>
#import "UIImage+Tint.h"
#import "UIColor+Hex.h"
@interface ZKRCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end


@implementation ZKRCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(ZKRRootTypeItem *)item
{
    _item = item;
    
    _titleLabel.text = item.title;
    
    // 加载图片, 并变换颜色
    NSURL *url = [NSURL URLWithString:item.pic];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    image = [image imageWithTintColor:[UIColor colorWithHexString:item.block_color]];
    
     /** 给内容类型添加图片 */
    if ([item.pic hasPrefix:@"http"]) {
        [_button setImage:image forState:UIControlStateNormal];
    } else {
        [_button setImage:[UIImage imageNamed:item.pic] forState:UIControlStateNormal];
    }
}

@end
