//
//  ZKRComChoiceViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRComChoiceViewController.h"
#import "ZKRRefreshHeader.h"
#import "AFHTTPSessionManager.h"
#import "ZKRCommentChoiceItem.h"
#import "MJExtension.h"
#import "ZKRComChoiceCell.h"
#import "ZKRRefreshFooter.h"
#import "ZKRComChoiceDetailController.h"
#import "SVProgressHUD.h"

/**
 *  社区->精选
 */
@interface ZKRComChoiceViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *itemsArray;

@property (nonatomic, strong) NSMutableString *loadOldDataUrl;

@end

static NSString *ComChoiceCell = @"ComChoiceCell";

@implementation ZKRComChoiceViewController

#pragma mark - ---| lazy load |---
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CGLCommonBgColor;
    
    [self setupRefresh];
    
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRComChoiceCell class]) bundle:nil] forCellReuseIdentifier:ComChoiceCell];
    
    // cell底部分割线去除
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [SVProgressHUD show];
    [self loadData];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [ZKRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewCell)];
    
    [self.tableView.mj_header beginRefreshing];
    
    // footer
    self.tableView.mj_footer = [ZKRRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCell)];
}

#pragma mark - ---| 加载数据 |---
- (void)loadData
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"]    = @"iphone";
    para[@"_udid"]     = @"48E21014-9B62-48C3-B818-02F902C1619E";
    para[@"_net"]      = @"wifi";
    para[@"_version"]  = @"6.46";
    para[@"_lbs_city"] = @"%E5%B9%BF%E5%B7%9E";
    
    [self.manager GET:@"http://dis.myzaker.com/api/get_post_selected.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.itemsArray = [ZKRCommentChoiceItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"posts"]];
        
//        ZKRCommentChoiceItem *item = self.itemsArray[0];
//        NSLog(@"%@", [item getAllPropertiesAndVaules]);
        
        /** 上拉刷新的连接 */
        self.loadOldDataUrl = responseObject[@"data"][@"info"][@"next_url"];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];

}

 /** 加载新数据 */
- (void)loadNewCell
{
    
//    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"]    = @"iphone";
    para[@"_udid"]     = @"48E21014-9B62-48C3-B818-02F902C1619E";
    para[@"_net"]      = @"wifi";
    para[@"_version"]  = @"6.46";
    para[@"_lbs_city"] = @"%E5%B9%BF%E5%B7%9E";
    
    [self.manager GET:@"http://dis.myzaker.com/api/get_post_selected.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.itemsArray = [ZKRCommentChoiceItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"posts"]];
        
        /** 上拉刷新的连接 */
        self.loadOldDataUrl = responseObject[@"data"][@"info"][@"next_url"];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)loadMoreCell
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [self.manager GET:self.loadOldDataUrl parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *items = [ZKRCommentChoiceItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"posts"]];
        [self.itemsArray addObjectsFromArray:items];
        /** 上拉刷新的连接 */
        self.loadOldDataUrl = responseObject[@"data"][@"info"][@"next_url"];

        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
}

#pragma mark - ---| date source |---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemsArray.count;
}

- (ZKRComChoiceCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKRComChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:ComChoiceCell];

    ZKRCommentChoiceItem *item = self.itemsArray[indexPath.row];
    
    cell.item = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRCommentChoiceItem *item = self.itemsArray[indexPath.row];
    return item.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRComChoiceDetailController *detailVC = [[ZKRComChoiceDetailController alloc]init];
    detailVC.item = self.itemsArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
