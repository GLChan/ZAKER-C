//
//  ZKRCollectionViewCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRCollectionViewCell.h"
#import "ZKRRootTypeItem.h"


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
    
     /** 给内容类型添加图片 */
    if (![item.pic hasPrefix:@"http"]) {
        [_button setImage:[UIImage imageNamed:item.pic] forState:UIControlStateNormal];
    }
    
    _titleLabel.text = item.title;
}

@end
