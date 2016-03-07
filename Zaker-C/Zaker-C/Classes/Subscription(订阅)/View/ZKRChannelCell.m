//
//  ZKRChannelCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRChannelCell.h"
#import "ZKRChannelItem.h"

@interface ZKRChannelCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end
@implementation ZKRChannelCell

- (void)awakeFromNib {
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
}

- (void)setItem:(ZKRChannelItem *)item
{
    _item = item;
    self.titleLabel.text = item.title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addButtonClick:(id)sender {
}

@end
