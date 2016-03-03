//
//  ZKRSlideView.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/17.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSlideView.h"
#import "ZKRSlideViewButton.h"

@interface ZKRSlideView()

@property (weak, nonatomic) IBOutlet ZKRSlideViewButton *cancelButton;

@property (weak, nonatomic) IBOutlet ZKRSlideViewButton *delButton;



@end

@implementation ZKRSlideView


- (ZKRSlideViewButton *)delButton
{
    if (!_delButton) {
        ZKRSlideViewButton *button = [[ZKRSlideViewButton alloc] init];
        _delButton = button;
//        _delButton.enabled = NO;
    }
    return _delButton;
}

- (void)awakeFromNib
{
    self.delButton.enabled = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.delButton.enabled = self.setupDelButtonEnableBlock();
    self.delButton.enabled = self.setupDelButtonEnable;
    
    
}

#pragma mark - ---| event |---

 /** 退出按钮点击 */
- (IBAction)cancelButtonClick:(UIButton *)sender {
//    NSLog(@"cancelButtonClick");
    [UIView animateWithDuration:0.3 animations:^{
        self.cgl_y = CGLScreenH;
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender.superview removeFromSuperview];
        self.deallocBlock();
        
    });
    
}

 /** 删除按钮点击 */
- (IBAction)deleteChannelButton:(UIButton *)sender {
//    NSLog(@"deleteChannelButton");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"频道管理" message:@"你已经选择了1频道, 确定要删除吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}


#pragma mark - ---| alert View delegate |---
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"%zd", buttonIndex);
    if (buttonIndex == 1) {
        NSLog(@"确定删除");
    }
}

@end
