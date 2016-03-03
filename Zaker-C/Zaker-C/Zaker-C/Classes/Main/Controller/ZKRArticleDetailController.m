//
//  ZKRArticleDetailController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/1.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRArticleDetailController.h"
#import "ZKRArticleItem.h"
#import "UIImageView+WebCache.h"
#import "ZKRArticleDetailTopView.h"
#import "AFHTTPSessionManager.h"
#import "ZKRArticleContentItem.h"
#import "MJExtension.h"
#define TitleViewHeight 120
#define StatusBarHeight 20

/**
 *  订阅->分类->新闻详情页
 */
@interface ZKRArticleDetailController ()<UIWebViewDelegate>
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) ZKRArticleContentItem *contentItem;
@property (nonatomic, strong) NSString *contentString;
@property (nonatomic, strong) UIWebView *webView;
@end

static NSString *CommentCellID = @"CommentCellID";

@implementation ZKRArticleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UITableViewCell class]) bundle:nil] forCellReuseIdentifier:CommentCellID];
//    NSLog(@"%@", [self.item getAllPropertiesAndVaules]);
    [self setupTableHeaderView];
    
    [self loadWebData];
}

- (void)setupTableHeaderView
{
    
    ZKRArticleDetailTopView *topView = [ZKRArticleDetailTopView cgl_viewFromXib];
    topView.frame = CGRectMake(0, -TitleViewHeight, CGLScreenW, TitleViewHeight);
    topView.item = self.item;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 350)];
    webView.delegate = self;
    webView.scrollView.contentInset = UIEdgeInsetsMake(TitleViewHeight, 0, 0, 0);
    [webView.scrollView addSubview:topView];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;

    self.webView = webView;
}

- (void)loadWebData
{
    NSString *url = self.item.full_url;
    
    self.manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [self.manager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ZKRArticleContentItem *contentItem  = [ZKRArticleContentItem mj_objectWithKeyValues:responseObject[@"data"]];
        self.contentItem = contentItem ;
        
        [self loadWebView:self.contentItem];
        [self.webView reload];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


 /** 加载网页 */
- (void)loadWebView:(ZKRArticleContentItem *)contentItem
{
    NSMutableString *html = [NSMutableString string];
    // 头部内容
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendString:@"</head>"];
    
    // 具体内容
    [html appendString:@"<body>"];
    
    [html appendString:[self setupBody:contentItem]];
    
    [html appendString:@"</body>"];
    
    // 尾部内容
    [html appendString:@"</html>"];
    
    // 显示网页
    [self.webView loadHTMLString:html baseURL:nil];
}

/**
 *  初始化body内容
 */
- (NSString *)setupBody:(ZKRArticleContentItem *)contentItem
{
    NSMutableString *body = [NSMutableString stringWithFormat:@"%@",contentItem.content];
    
    [contentItem.media enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableString *m_url = obj[@"m_url"];
        NSString *imgTargetString = [NSString stringWithFormat:@"id=\"id_image_%zd\" class=\"\" src=\"article_html_content_loading.png\"", idx];
        NSString *imgReplaceString = [NSString stringWithFormat:@"id=\"id_image_%zd\" class=\"\" src=\"%@\"", idx, m_url];
        
//        NSString *divTargetString = [NSString stringWithFormat:@"<div class=\"img_box\" id=\"id_imagebox_0\" style=\"height:168px; overflow:hidden;\" onclick='window.location.href=\"http://www.myzaker.com/?_zkcmd=open_media&index=0\"'>"];
//        NSString *divReplaceString = [NSString stringWithFormat:@"<div class=\"img_box\" id=\"id_imagebox_0\" style=\"height:168px; overflow:hidden;\" onclick='window.location.href=\"http://www.myzaker.com/?_zkcmd=open_media&index=0\"'>"];
        
        [body replaceOccurrencesOfString:imgTargetString withString:imgReplaceString options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }];
    
    return body;
}

#pragma mark - ---| webView delegate |---
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     /** 加载后的webView高度 */
    CGFloat webViewHeight= [[webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]floatValue];
    
     /** webView新增底部view */
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, webViewHeight + 20, CGLScreenW, 100)];
    view.backgroundColor = ZKRRedColor;
    [webView.scrollView addSubview:view];

    webView.cgl_height = webViewHeight + TitleViewHeight + StatusBarHeight + 100;
    
    self.tableView.tableHeaderView = webView;

    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 50)];
    view.backgroundColor = [UIColor blueColor];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellID forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellID];
//    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
