//
//  ZKRFunViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/25.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRFunViewController.h"
#import "ZKRBarButtonItem.h"

#import "UIBarButtonItem+CGLExtension.h"
@interface ZKRFunViewController ()

@end

@implementation ZKRFunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"玩乐";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"life_my_account" highImage:@"life_my_account" target:self action:@selector(accountClick)];
    
    ZKRBarButtonItem *btn = [[ZKRBarButtonItem alloc] init];
    [btn setImage:[UIImage imageNamed:@"nav_location"] forState:UIControlStateNormal];
    [btn setTitle:@"广州" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    //让按钮的大小自适应.
    [btn sizeToFit];
    //自定义UIView,必须得要设置尺寸.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

- (void)locationClick
{
    CGLFunc
}

- (void)accountClick
{
    CGLFunc
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
