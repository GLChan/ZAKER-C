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

@property (weak, nonatomic) IBOutlet UIImageView *tickImageView;
//@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end


@implementation ZKRCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.ttickImageView = self.tickImageView;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
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
        _cellImageView.image = image;
    } else {
        _cellImageView.image = [UIImage imageNamed:item.pic];
    }
    
    _tickImageView.image = [_tickImageView.image imageWithTintColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1]];
}

- (void)setSelected:(BOOL)selected
{
    UIImage *image = self.tickImageView.image;
    
    if (selected) {
        self.ttickImageView.image = [image imageWithTintColor:[UIColor redColor]];
    } else {
        self.ttickImageView.image = [image imageWithTintColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1]];
        //        self.ttickImageView.image = image;
    }
    [super setSelected:selected];
}

- (void)setEditing:(BOOL)editing
{
    UIImage *image = self.tickImageView.image;
    
    if (editing) {
        self.ttickImageView.image = [image imageWithTintColor:[UIColor redColor]];
    } else {
        self.ttickImageView.image = [image imageWithTintColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1]];
        //        self.ttickImageView.image = image;
    }
}


@end
