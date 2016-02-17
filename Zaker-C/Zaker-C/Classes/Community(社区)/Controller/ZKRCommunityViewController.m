//
//  ZKRCommunityViewController.m
//  Zaker-C
//
//  Created by ShaoXinSen on 16/1/25.
//  Copyright © 2016年 SKX. All rights reserved.
//

#import "ZKRCommunityViewController.h"

#import "UIBarButtonItem+CGLExtension.h"
#import "ZKRMineTableController.h"
#import "ZKRAccountBarButtonItem.h"
@interface ZKRCommunityViewController ()

@end

@implementation ZKRCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"社区";
    self.navigationItem.leftBarButtonItem = [ZKRAccountBarButtonItem itemWithImage:@"life_my_account" highImage:@"life_my_account" navigationController:self.navigationController];
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
