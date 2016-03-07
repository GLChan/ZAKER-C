//
//  ZKRSearchChannelCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSearchChannelCell.h"
#import "ZKRChannelGroupItem.h"
#import "UIImageView+WebCache.h"

@interface ZKRSearchChannelCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZKRSearchChannelCell

- (void)awakeFromNib {
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
}

- (void)setItem:(ZKRChannelGroupItem *)item
{
    _item = item;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.list_icon]];
    self.titleLabel.text = item.title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
