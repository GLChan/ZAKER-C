//
//  ZKRComChoiceCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRComChoiceCell.h"
#import "ZKRCommentChoiceItem.h"
#import "UIImageView+WebCache.h"
#import "ZKRChoiceOnePicView.h"
#import "ZKRChoiceTwoPicView.h"
#import "ZKRChoiceThreePicView.h"
#import "UIView+Init.h"

@interface ZKRComChoiceCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *discussionTitleButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userFlagImageView;

@property (weak, nonatomic) IBOutlet UIButton *hotButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

// 中间图片
@property (nonatomic, weak) ZKRChoiceOnePicView *onePicView;
@property (nonatomic, weak) ZKRChoiceTwoPicView *twoPicsView;
@property (nonatomic, weak) ZKRChoiceThreePicView *threePicsView;

@end

@implementation ZKRComChoiceCell
#pragma mark - ---| lazy load |---
- (ZKRChoiceOnePicView *)onePicView
{
    if (!_onePicView) {
        ZKRChoiceOnePicView *onePicView = [ZKRChoiceOnePicView cgl_viewFromXib];
        [self.contentView addSubview:onePicView];
        _onePicView = onePicView;
    }
    return _onePicView;
}

- (ZKRChoiceTwoPicView *)twoPicsView
{
    if (!_twoPicsView) {
        ZKRChoiceTwoPicView *twoPicsView = [ZKRChoiceTwoPicView cgl_viewFromXib];
        [self.contentView addSubview:twoPicsView];
        _twoPicsView = twoPicsView;
    }
    return _twoPicsView;
}

- (ZKRChoiceThreePicView *)threePicsView
{
    if (!_threePicsView) {
        ZKRChoiceThreePicView *threePicsView = [ZKRChoiceThreePicView cgl_viewFromXib];
        [self.contentView addSubview:threePicsView];
        _threePicsView = threePicsView;
    }
    return _threePicsView;
}


#pragma mark - ---| layout |---
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.item.item_type intValue] == CGLItemTypeOne) {
        self.onePicView.frame    = self.item.centerFrame;
    } else if ([self.item.item_type intValue] == CGLItemTypeTwo) {
        self.twoPicsView.frame   = self.item.centerFrame;
    } else if ([self.item.item_type intValue] == CGLItemTypeThree) {
        self.threePicsView.frame = self.item.centerFrame;
    }

}


- (void)setItem:(ZKRCommentChoiceItem *)item
{
    _item = item;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.userNameLabel.text = item.name;
    self.dateLabel.text = item.list_date;
    
    // 右侧话题标签
    if (item.discussion_title) {
        [self.discussionTitleButton setTitle:[NSString stringWithFormat:@"#%@", item.discussion_title] forState:UIControlStateNormal];
        self.discussionTitleButton.hidden = NO;
    } else {
        [self.discussionTitleButton setTitle:@"" forState:UIControlStateNormal];
        self.discussionTitleButton.hidden = YES;
    }
    
    
    self.contentLabel.text = item.content;
    [self.userFlagImageView sd_setImageWithURL:[NSURL URLWithString:item.user_flag]];
    
    // 底部
    [self setButton:self.hotButton WithNum:item.hot_num];
    [self setButton:self.commentButton WithNum:item.comment_count];
    [self setButton:self.likeButton WithNum:item.like_num];
    
    // 中间内容
    if ([item.item_type intValue] == CGLItemTypeOne) {// 一张图片
        self.onePicView.hidden = NO;
        self.twoPicsView.hidden = YES;
        self.threePicsView.hidden = YES;
        self.onePicView.item = item;
    } else if ([item.item_type intValue] == CGLItemTypeTwo) {// 两张图片
        self.onePicView.hidden = YES;
        self.twoPicsView.hidden = NO;
        self.threePicsView.hidden = YES;
        self.twoPicsView.item = item;
    } else if ([item.item_type intValue] == CGLItemTypeThree) {// 三张图片
        self.onePicView.hidden = YES;
        self.twoPicsView.hidden = YES;
        self.threePicsView.hidden = NO;
        self.threePicsView.item = item;
    } else {
        self.onePicView.hidden = YES;
        self.twoPicsView.hidden = YES;
        self.threePicsView.hidden = YES;
    }
    
}

- (void)setButton:(UIButton *)button WithNum:(NSString *)num{
    NSInteger number = [num intValue];
    
    CGFloat floatNum = 0.0;
    if (number >= 1000) {
        floatNum = number / 1000.0;
        [button setTitle:[NSString stringWithFormat:@"  %.1lfK", floatNum] forState:UIControlStateNormal];
    } else {
        [button setTitle:[NSString stringWithFormat:@"  %zd", number] forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setHighlighted:(BOOL)highlighted{}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

@end
