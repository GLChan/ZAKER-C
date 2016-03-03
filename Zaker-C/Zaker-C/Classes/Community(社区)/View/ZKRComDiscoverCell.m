//
//  ZKRComDiscoverCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRComDiscoverCell.h"
#import "UIImageView+WebCache.h"
#import "ZKRCommentCellItem.h"

@interface ZKRComDiscoverCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end


@implementation ZKRComDiscoverCell
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layoutMargins = UIEdgeInsetsZero;
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.size.height -= 1;
//    [super setFrame:frame];
//}

- (void)setItem:(ZKRCommentCellItem *)item
{
    _item = item;
    
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:item.pic]];
    
    self.titleLabel.text = item.title;
    
    self.subTitleLabel.text = item.stitle;
}

- (IBAction)addButtonClick:(UIButton *)sender {
    if (self.addButtonClickBlock) {
        self.addButtonClickBlock();
    }
}

@end
