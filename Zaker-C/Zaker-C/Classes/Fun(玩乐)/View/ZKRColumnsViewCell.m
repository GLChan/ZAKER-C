//
//  ZKRColumnsViewCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/19.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRColumnsViewCell.h"
#import "ZKRFunCellItem.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"

@interface ZKRColumnsViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *lightGrayView;

@end

@implementation ZKRColumnsViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 3;
    [super setFrame:frame];
}

#pragma mark - ---| item |---
- (void)setCellItem:(ZKRFunCellItem *)cellItem
{
    _cellItem = cellItem;
    
    self.titleLabel.text = cellItem.title;
    self.contentLabel.text = cellItem.content;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:cellItem.pic[@"url"]] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.lightGrayView.hidden = NO;
        self.progressView.hidden = YES;
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
@end
