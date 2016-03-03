//
//  ZKRComChoiceDetailController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRComChoiceDetailController.h"
#import "ZKRCommentChoiceItem.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "NJKWebViewProgress.h"
/**
 *  社区->精选->详情
 */
@interface ZKRComChoiceDetailController()<UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource,NJKWebViewProgressDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *mainView;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@end

@implementation ZKRComChoiceDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [SVProgressHUD show];
    // 顶部view 加载
    [self setupTopView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, CGLScreenH - 35 - 64)];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.mainView addSubview:tableView];
    
    [self setupWebView];
}

- (void)setupWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.mainView.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.item.content_url]];
    [webView loadRequest:request];
    webView.scrollView.scrollEnabled = NO;
    self.webView = webView;
    
    // 用来监听web加载进度
    NJKWebViewProgress *progressProxy = [[NJKWebViewProgress alloc] init];
    self.progressProxy = progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
    self.webView.delegate = self.progressProxy;
    
    self.webView.backgroundColor = [UIColor whiteColor];
}

 /** 加载顶部视图 */
- (void)setupTopView
{
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.item.icon]];
    //    NSLog(@"%@", item.icon);
    self.userNameLabel.text = self.item.name;
    self.timeLabel.text = self.item.date;
}

- (IBAction)returnButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark - ---| webView delegate |---
/** 这里获取的高度未必就是web页面的真实高度 */
//- (void)webViewDidFinishLoad:(UIWebView *)webView {}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//        [UIView animateWithDuration:0.27 animations:^{
//            _progressView.alpha = 1.0;
//        }];
    }
    
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [UIView animateWithDuration:0.27 delay:progress - _progressView.progress options:0 animations:^{
//            _progressView.alpha = 0.0;
//            } completion:nil];
    
            // webView彻底加载完
//        CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
        
        
        self.webView.cgl_height = self.webView.scrollView.contentSize.height;
        
        
        self.tableView.tableHeaderView = self.webView;
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }
}

#pragma mark - ---| event |---

- (IBAction)settingButtonClick:(UIButton *)sender
{
//    NSLog(@"settingButtonClick" );
}

#pragma mark - ---| tableView source  |---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}
@end
