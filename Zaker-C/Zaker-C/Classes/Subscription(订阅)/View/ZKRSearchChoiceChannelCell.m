//
//  ZKRSearchChoiceChannelCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSearchChoiceChannelCell.h"
#import "ZKRSearchChoiceChannelItem.h"
#import "UIImageView+WebCache.h"

@interface ZKRSearchChoiceChannelCell()

@property (weak, nonatomic) IBOutlet UIImageView *channelImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *stitleLabel;

@end

@implementation ZKRSearchChoiceChannelCell

- (void)awakeFromNib {
    // Initialization code
    self.separatorInset = UIEdgeInsetsZero;
    
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y +=1;
//    frame.size.height -= 1;
//    [super setFrame:frame];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(ZKRSearchChoiceChannelItem *)item
{
    _item = item;
//    NSLog(@"%@", item);
    // 加载图片, 并变换颜色
    NSURL *url = [NSURL URLWithString:item.large_pic];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    image = [image imageWithTintColor:[UIColor colorWithHexString:item.block_color]];
    
    self.channelImageView.image = image;
    
    self.channelImageView.layer.cornerRadius = self.channelImageView.cgl_width * 0.5;
    self.channelImageView.layer.borderWidth = 0.5;
    self.channelImageView.layer.borderColor = [UIColor colorWithHexString:item.block_color].CGColor;
    
    [self.channelImageView.layer masksToBounds];
    
    self.titleLabel.text = item.title;
    self.stitleLabel.text = item.stitle;
    
}

@end
