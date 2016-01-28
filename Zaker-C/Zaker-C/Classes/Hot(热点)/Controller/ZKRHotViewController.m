//
//  ZKRHotViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/25.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRHotViewController.h"
#import "UIBarButtonItem+CGLExtension.h"

@interface ZKRHotViewController ()

@end

@implementation ZKRHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"热点";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"life_my_account" highImage:@"life_my_account" target:self action:@selector(accountClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"DailyHot_PreferencesButton" highImage:@"DailyHot_PreferencesButton_inDark" target:self action:@selector(dailyHotClick)];
}

- (void)accountClick
{
    CGLFunc
}

- (void)dailyHotClick
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
