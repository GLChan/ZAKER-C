//
//  ZKRChoiceOnePicView.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRChoiceOnePicView.h"
#import "ZKRCommentChoiceItem.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"

@interface ZKRChoiceOnePicView()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UIButton *picNumButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation ZKRChoiceOnePicView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.progressView.roundedCorners = 5;
//    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.picNumButton.hidden = YES;
}

 /** 加载 */
- (void)setItem:(ZKRCommentChoiceItem *)item
{
    _item = item;
    
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:item.url] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // receivedSize : 已经接收的图片大小
        // expectedSize : 图片的总大小
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    if (!([item.medias_count intValue] <= 3)) {
        [self.picNumButton setTitle:item.medias_count forState:UIControlStateNormal];
        self.picNumButton.hidden = NO;
    } else {
        self.picNumButton.hidden = YES;
    }
    
    if (self.item.isBigPicture) {
        [self.picImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        self.picImageView.contentMode   = UIViewContentModeScaleAspectFill;
        self.picImageView.clipsToBounds = YES;
    } else {
        self.picImageView.contentMode   = UIViewContentModeScaleToFill;
        self.picImageView.clipsToBounds = NO;
    }
}

@end
