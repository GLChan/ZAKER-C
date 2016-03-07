//
//  ZKRSearchChoiceTopView.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSearchChoiceTopView.h"
#import "AFHTTPSessionManager.h"
#import "ZKRSearchChoiceTopItem.h"
#import "UIButton+WebCache.h"

@interface ZKRSearchChoiceTopView()
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation ZKRSearchChoiceTopView


- (void)setItems:(NSArray *)items
{
    _items = items;
    
    [items enumerateObjectsUsingBlock:^(ZKRSearchChoiceTopItem  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = self.buttons[idx];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:obj.promotion_img] forState:UIControlStateNormal];
        
        self.buttons[idx] = btn;
    }];
    
    
}

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray arrayWithObjects:self.topButton, self.leftButton, self.rightButton,nil];
    }
    return _buttons;
}

@end
