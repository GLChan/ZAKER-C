//
//  ZKRComChoiceViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRComDiscTopicController.h"
#import "ZKRRefreshHeader.h"
#import "AFHTTPSessionManager.h"
#import "ZKRCommentChoiceItem.h"
#import "MJExtension.h"
#import "ZKRComChoiceCell.h"
#import "ZKRRefreshFooter.h"
#import "ZKRComChoiceDetailController.h"
#import "ZKRCommentCellItem.h"
#import "SVProgressHUD.h"

/**
 *  社区->发现->话题
 */
@interface ZKRComDiscTopicController ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *itemsArray;

@property (nonatomic, strong) NSMutableString *pre_url;
@property (nonatomic, strong) NSMutableString *next_url;

@end

static NSString *ComChoiceCell = @"ComChoiceCell";

@implementation ZKRComDiscTopicController

#pragma mark - ---| lazy load |---
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - ---| load view |---
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = CGLCommonBgColor;
    UIBarButtonItem *nItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self.navigationItem setRightBarButtonItem:nItem];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRComChoiceCell class]) bundle:nil] forCellReuseIdentifier:ComChoiceCell];
    
    // cell底部分割线去除
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [SVProgressHUD show];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [ZKRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.tableView.mj_header beginRefreshing];
    
    // footer
    self.tableView.mj_footer = [ZKRRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCell)];
}

- (void)setItem:(ZKRCommentCellItem *)item
{
    _item = item;
//    NSLog(@"%@", [item getAllPropertiesAndVaules]);
    
    [self setupRefresh];
    [self loadData];
}

#pragma mark - ---| 加载数据 |---
- (void)loadData
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [self.manager GET:self.item.api_url parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.itemsArray = [ZKRCommentChoiceItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"posts"]];
        
        self.pre_url = responseObject[@"data"][@"info"][@"pre_url"];
        self.next_url = responseObject[@"data"][@"info"][@"next_url"];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}



- (void)loadMoreCell
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [self.manager GET:self.next_url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *items = [ZKRCommentChoiceItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"posts"]];
        [self.itemsArray addObjectsFromArray:items];
        /** 上拉刷新的连接 */
        self.pre_url = responseObject[@"data"][@"info"][@"pre_url"];
        self.next_url = responseObject[@"data"][@"info"][@"next_url"];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
}

#pragma mark - ---| date source |---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
