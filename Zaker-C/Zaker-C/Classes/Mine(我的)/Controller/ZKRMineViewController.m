//
//  ZKRMineViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/28.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRMineViewController.h"

@interface ZKRMineViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ZKRMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //头像圆形处理
    _iconImageView.layer.cornerRadius = _iconImageView.cgl_width * 0.5;
    [_iconImageView.layer masksToBounds];
    
    self.navigationItem.title = @"我的";
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
