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
#import "SVProgressHUD.h"
#import "ZKRArticleCommentGroupItem.h"
#import "ZKRArticleCommentItem.h"
#import "ZKRArticleCommentCell.h"
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

@property (nonatomic, strong) NSMutableArray *commentGroupsArray;

@end
/**
 *  暂存问题:
    点赞动画
    组头部会停留在顶部
 */
static NSString *ArticleCommentCell = @"ArticleCommentCell";
@implementation ZKRArticleDetailController
#pragma mark - ---| lazy load |---
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

//- (instancetype)initWithStyle:(UITableViewStyle)style
//{
//    return [super initWithStyle:UITableViewStyleGrouped];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGLScreenW, 20)];
    view.backgroundColor = [UIColor colorWithHexString:self.item.block_color alpha:0.8];
    [self.view addSubview:view];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRArticleCommentCell class]) bundle:nil] forCellReuseIdentifier:ArticleCommentCell];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0);
    [SVProgressHUD show];
    [self setupTableHeaderView];
    
    [self loadWebData];

    
}

#pragma mark - ---| 加载view |---
- (void)setupTableHeaderView
{
    
    ZKRArticleDetailTopView *topView = [ZKRArticleDetailTopView cgl_viewFromXib];
    topView.frame = CGRectMake(0, -TitleViewHeight, CGLScreenW, TitleViewHeight);
    topView.item = self.item;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 350)];
    webView.delegate                 = self;
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.contentInset  = UIEdgeInsetsMake(TitleViewHeight, 0, 0, 0);

    [webView.scrollView addSubview:topView];
    self.webView = webView;
}

#pragma mark - ---| load data |---
/**
 *  加载评论数据
 */
- (void)loadCommentData
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"]   = @"iphone";
    para[@"_version"] = @"6.46";
    para[@"act"]      = @"get_comments";
    para[@"pk"]       = self.item.pk;
    
    [self.manager GET:@"http://c.myzaker.com/weibo/api_comment_article_url.php?" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.commentGroupsArray = [ZKRArticleCommentGroupItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"comments"]];
        
        [self.commentGroupsArray enumerateObjectsUsingBlock:^(ZKRArticleCommentGroupItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {

            if (obj.list.count != 0) {
                obj.list = [ZKRArticleCommentItem mj_objectArrayWithKeyValuesArray:obj.list];
            }
            self.commentGroupsArray[idx] = obj;
        }];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

 /** 加载网页信息 */
- (void)loadWebData
{
    NSString *url = self.item.full_url;
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [self.manager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZKRArticleContentItem *contentItem  = [ZKRArticleContentItem mj_objectWithKeyValues:responseObject[@"data"]];
        self.contentItem = contentItem ;
        
        [self loadWebView:self.contentItem];
        [self.webView reload];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

 /** 设置网页内容格式 */
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
 *  初始化网页body内容
 */
- (NSString *)setupBody:(ZKRArticleContentItem *)contentItem
{
    NSMutableString *body = [NSMutableString stringWithFormat:@"%@",contentItem.content];

    
    [contentItem.media enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableString *m_url = obj[@"m_url"];
        
        // 原div点击事件
        NSMutableString *div   = [NSMutableString stringWithFormat:@"onclick='window.location.href=\"http://www.myzaker.com/?_zkcmd=open_media&index=%zd\"'", idx];
        // 替换的div点击事件
        NSMutableString *reDiv = [NSMutableString stringWithFormat:@"onclick='alert(this.src)'"];
        
        [body replaceOccurrencesOfString:div withString:reDiv options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
        
        
        
        NSString *imgTargetString  = [NSString stringWithFormat:@"id=\"id_image_%zd\" class=\"\" src=\"article_html_content_loading.png\"", idx];
        NSString *imgReplaceString = [NSString stringWithFormat:@"id=\"id_image_%zd\" class=\"\" src=\"%@\"", idx, m_url];

        [body replaceOccurrencesOfString:imgTargetString withString:imgReplaceString options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }];
//    NSLog(@"%@", body);
    return body;
}



#pragma mark - ---| webView delegate |---
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     /** 加载后的webView高度 */
    CGFloat webViewHeight= [[webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]floatValue];
    
     /** webView新增底部view */
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, webViewHeight + 20, CGLScreenW, 100)];

    [webView.scrollView addSubview:view];

    webView.cgl_height = webViewHeight + TitleViewHeight + StatusBarHeight + 100;
    
    self.tableView.tableHeaderView = webView;
    
    [self.tableView reloadData];
    
    // 在网页加载后加载评论
    [self loadCommentData];
    
}

/**
 *  每当webView发送请求之前都会先调用的方法
 *
 *  @param webView
 *  @param request        即将发送的请求
 *  @param navigationType
 *
 *  @return 代理返回yes允许发送请求,返回no禁止发送这个请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.commentGroupsArray.count;
}

 /** 评论数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZKRArticleCommentGroupItem *group = self.commentGroupsArray[section];
    return group.list.count;
}


- (ZKRArticleCommentCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRArticleCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ArticleCommentCell];
    
    ZKRArticleCommentGroupItem *group = self.commentGroupsArray[indexPath.section];
    ZKRArticleCommentItem *item = group.list[indexPath.row];
    
    cell.item = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRArticleCommentGroupItem *group = self.commentGroupsArray[indexPath.section];
    ZKRArticleCommentItem *item = group.list[indexPath.row];
    return item.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 10)];
    view.backgroundColor = [UIColor whiteColor];
    
    ZKRArticleCommentGroupItem *group = self.commentGroupsArray[section];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 40, 10)];
//    label.text = group.title;
    NSDictionary *att = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:10],
                          NSForegroundColorAttributeName : [UIColor lightGrayColor]
                          };
    
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:group.title attributes:att];
    
    [label setAttributedText:attStr];
    
    
    [view addSubview:label];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 10, label.center.y, view.cgl_width - CGRectGetMaxX(label.frame) - 30, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineView];
    
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
@end
