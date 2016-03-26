//
//  ZKRLoginViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRLoginViewController.h"
#import "ZKRInfiniteScrollView.h"
#import "ZKRZAKERLoginController.h"

@interface ZKRLoginViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation ZKRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
}

- (void)setupScrollView
{
    // scrollView
    ZKRInfiniteScrollView *scrollView = [[ZKRInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    scrollView.images = @[
                          [UIImage imageNamed:@"FeaturesGallery-1"],
                          [UIImage imageNamed:@"FeaturesGallery-2"],
                          [UIImage imageNamed:@"FeaturesGallery-3"]
                          ];
//    scrollView.delegate = self;
    scrollView.frame = self.centerView.bounds;

    [self.centerView addSubview:scrollView];

}


 /** 隐藏状态栏 */
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - ---| event |---
 /** 关闭按钮点击 */
- (IBAction)closeButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

 /** 微博登录按钮 */
- (IBAction)weiboLoginButtonClick:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"\"ZAKER\"想要打开\"新浪微博\"" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开", nil];
    [alertView show];
}

 /** 腾讯QQ登录按钮 */
- (IBAction)tencentLoginButtonClick:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"\"ZAKER\"想要打开\"QQ\"" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开", nil];
    [alertView show];
}

- (IBAction)zakerLoginButtonClick:(UIButton *)sender {
    ZKRZAKERLoginController *zakerVC = [[ZKRZAKERLoginController alloc] init];
    
    [self presentViewController:zakerVC animated:YES completion:nil];
}

@end
