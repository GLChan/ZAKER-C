//
//  ZKRArticleViewCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/8.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRArticleViewCell.h"
#import "UIImageView+WebCache.h"


@interface ZKRArticleViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *mediaImgView;

@end

@implementation ZKRArticleViewCell

- (void)setMedia:(NSString *)media
{
    _media = media;
    [self.mediaImgView sd_setImageWithURL:[NSURL URLWithString:media]];
    self.mediaImgView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

@end
