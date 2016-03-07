//
//  ZKRArticleCommentCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/7.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRArticleCommentCell.h"
#import "ZKRArticleCommentItem.h"
#import "UIImageView+WebCache.h"
@interface ZKRArticleCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


@end

@implementation ZKRArticleCommentCell
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
}

- (void)setItem:(ZKRArticleCommentItem *)item
{
    _item = item;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.auther_icon] placeholderImage:[UIImage imageNamed:@"circle_default_avatar"]];
    self.nameLabel.text = item.auther_name;
    self.timeLabel.text = item.time;
    [self.likeButton setTitle:[NSString stringWithFormat:@"%@赞", item.like_num ] forState:UIControlStateNormal];
    self.commentLabel.text = item.content;
    
}

- (IBAction)likeButtonClick:(UIButton *)sender {
    
    NSInteger likeNum =  [sender.titleLabel.text integerValue];
    if (sender.isSelected) {
        [sender setSelected:NO];
        [sender setTitle:[NSString stringWithFormat:@"%zd赞", likeNum] forState:UIControlStateNormal];
    } else {
        [sender setSelected:YES];
        [sender setTitle:[NSString stringWithFormat:@"%zd赞", likeNum + 1] forState:UIControlStateSelected];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
@end
