//
//  ZKRHotTableViewCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/21.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRHotTableViewCell.h"
#import "ZKRHotCellItem.h"
#import "UIImageView+WebCache.h"

@interface ZKRHotTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeImageConstraint;

@end


@implementation ZKRHotTableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cellImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.cellImageView.clipsToBounds = YES;
    
    self.typeImageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    if ([self.titleLabel.text isEqualToString:@""]) {
//        self.typeImageLeftConstraint.constant = -20;
//        [self updateConstraintsIfNeeded];
//    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 8;
    [super setFrame:frame];
}

#pragma mark - ---| item |---
- (void)setCellItem:(ZKRHotCellItem *)cellItem
{
    _cellItem = cellItem;
    
    self.titleLabel.text = _cellItem.title;
    self.authorLabel.text = [NSString stringWithFormat:@"%@ %@", _cellItem.auther_name, _cellItem.date];
    
    if (_cellItem.thumbnail_medias.count) {
        [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:_cellItem.thumbnail_medias[0][@"url"]]];
    }
    
    if (_cellItem.special_info[@"icon_url"]) {
        [self.typeImageView sd_setImageWithURL:[NSURL URLWithString:_cellItem.special_info[@"icon_url"]]];
        self.typeImageView.hidden = NO;
    } else {
        self.typeImageView.hidden = YES;
    }
    
    if (!self.authorLabel.text) {
        //改变typeImage左约束
//        self.typeImageConstraint.constant = 0;
    } else {
//        self.typeImageConstraint.constant = 10;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //    [super setSelected:selected animated:animated];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
@end
