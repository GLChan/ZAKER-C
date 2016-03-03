//
//  ZKRArticleViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/1.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRArticleViewController.h"
#import "ZKRArticleDetailController.h"
#import "ZKRArticleItem.h"


@interface ZKRArticleViewController ()
@property (weak, nonatomic) IBOutlet UIView *articleView;
@property (nonatomic, strong) ZKRArticleDetailController *articleDetailVC;
@end

@implementation ZKRArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    ZKRArticleDetailController *articleDetailVC = [[ZKRArticleDetailController alloc] init];
    articleDetailVC.item = self.item;
    [self.articleView addSubview:articleDetailVC.view];
    self.articleDetailVC = articleDetailVC;
}



#pragma mark - ---| event |---
 /** 返回上一级 */
- (IBAction)backButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    // 如果上一层是主控制器那就显示navigationBar
    if ([self.preVC isEqualToString:@"ZKRColoumnsViewController"]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

 /** 分享 */
- (IBAction)shareButtonClick:(UIButton *)sender {
    
}

 /** 查看评论 */
- (IBAction)commentButtonClick:(UIButton *)sender {
    
}
 /** 回复按钮 */
- (IBAction)answerButtonClick:(UIButton *)sender {
    
}

 /** 设置按钮 */
- (IBAction)moreSettingButtonClick:(UIButton *)sender {
    
}




@end
