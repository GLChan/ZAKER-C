//
//  ZKRSlideView.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/17.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSlideView.h"

@interface ZKRSlideView()



@end

@implementation ZKRSlideView


- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.cancelEditingButton.imageView.center = CGPointMake(_cancelEditingButton.cgl_width * 0.5, _cancelEditingButton.cgl_height * 0.4);
//    NSLog(@"%@", NSStringFromCGRect(self.cancelEditingButton.imageView.frame));
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
//    NSLog(@"cancelButtonClick");
    [UIView animateWithDuration:0.3 animations:^{
        self.cgl_y = CGLScreenH;
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender.superview removeFromSuperview];
    });
}

- (IBAction)deleteChannelButton:(UIButton *)sender {
//    NSLog(@"deleteChannelButton");
    
}

@end
