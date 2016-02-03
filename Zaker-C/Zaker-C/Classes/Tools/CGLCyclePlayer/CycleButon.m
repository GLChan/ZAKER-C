#define ButtonW self.frame.size.width
#define ButtonH self.frame.size.height

#define ImageViewW self.imageView.frame.size.width
#define ImageViewH self.imageView.frame.size.height

#define LabelW self.titleLabel.frame.size.width
#define LabelH self.titleLabel.frame.size.height

#import "CycleButon.h"
#import "UIButton+WebCache.h"
#import "ZKRRotationItem.h"
@implementation CycleButon
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupImageView];
    [self setupTitleLabel];
    self.highlighted = NO;
}

/** 设置imageView */
- (void)setupImageView
{
    //根据判断tag的类型改变图片中小标签的位置
    if (![self.tag_type isEqualToString:@"广告"]) {
        self.imageView.frame = CGRectMake(ButtonW- ImageViewW, 10, ImageViewW, ImageViewH);
    } else {
        self.imageView.frame = CGRectMake(0, ButtonH - ImageViewH - 10, ImageViewW, ImageViewH);
    }
}

/** 设置titleLabel */
- (void)setupTitleLabel
{
    // 设置titleLabel的属性
    NSMutableDictionary *attDict            = [NSMutableDictionary dictionary];
    attDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attDict[NSFontAttributeName]            = [UIFont systemFontOfSize:16];
    
    // 设置阴影
    NSShadow *shadow               = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(1.0, 1.0)];
    attDict[NSShadowAttributeName] = shadow;
    
    // $$$$$ 一定要判断字符是否为空, 否则添加富文本属性的时候会报错!!!
    if (self.item.title) {
        NSAttributedString *attStr     = [[NSAttributedString alloc] initWithString:self.item.title attributes:attDict];
        [self setAttributedTitle:attStr forState:UIControlStateNormal];
    }
    //设置label的位置
    self.titleLabel.frame = CGRectMake(10, ButtonH - LabelH - 10, LabelW, LabelH);
}



@end
