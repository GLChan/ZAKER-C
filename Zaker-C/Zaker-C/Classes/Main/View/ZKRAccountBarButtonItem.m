//
//  ZKRAccountBarButtonItem.m
//  Zaker-C
//
//  Created by 邵鑫森 on 16/2/16.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRAccountBarButtonItem.h"
#import "ZKRMineTableController.h"

@interface ZKRAccountBarButtonItem ()

@property (nonatomic, readwrite, weak) UINavigationController *naviVC;

@end


@implementation ZKRAccountBarButtonItem

+ (instancetype)itemWithImage:(NSString *)imageName highImage:(NSString *)highImageName navigationController:(UINavigationController *)navi {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    UIView *buttonView = [[UIView alloc] initWithFrame:button.bounds];
    [buttonView addSubview:button];
    
    ZKRAccountBarButtonItem *item = [[self alloc]initWithCustomView:button];
    [button addTarget:item action:@selector(pushAccountView) forControlEvents:UIControlEventTouchUpInside];
    item.naviVC = navi;
    return item;
}

- (void)pushAccountView{
    UIStoryboard *mineStoryBoard = [UIStoryboard storyboardWithName:NSStringFromClass([ZKRMineTableController class]) bundle:nil];
    
    ZKRMineTableController *mineVC = [mineStoryBoard instantiateInitialViewController];
    [self.naviVC pushViewController:mineVC animated:YES];
}


@end
