//
//  ZKRComDiscoverViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRComDiscoverViewController.h"
#import "ZKRComDiscoverCell.h"
#import "ZKRCommentCellItem.h"
#import "AFHTTPSessionManager.h"
#import "MJExtension.h"
#import "ZKRLoginViewController.h"
#import "ZKRComDiscTopicController.h"
#import "SVProgressHUD.h"
/**
 *  社区->发现
 */
@interface ZKRComDiscoverViewController ()

@property (nonatomic, strong) NSMutableArray *itemsArray;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) NSInteger loadMoreCount;

@end


@implementation ZKRComDiscoverViewController
#pragma mark - ---| lazy load |---
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

static NSString *ID = @"DiscoverCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 10, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRComDiscoverCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [UIColor blueColor];
    self.loadMoreCount = 0;
    
    [SVProgressHUD show];
    [self loadData];
    
}

 /** 初始加载 */
- (void)loadData
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"] = @"iphone";
    para[@"_udid"] = @"48E21014-9B62-48C3-B818-02F902C1619E";
    para[@"_net"] = @"wifi";
    para[@"_version"] = @"6.46";
    //    para[@"act"] = @"more_discussion";
    
    [self.manager GET:@"http://dis.myzaker.com/api/list_discussion.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.itemsArray =  [ZKRCommentCellItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

 /** 加载更多 */
- (void)loadMoreData
{
    if (self.loadMoreCount == 1) {
        return;
    }
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"] = @"iphone";
    para[@"_udid"] = @"48E21014-9B62-48C3-B818-02F902C1619E";
    para[@"_net"] = @"wifi";
    para[@"_version"] = @"6.46";
    para[@"act"] = @"more_discussion";
    para[@"except_recommend"] = @"Y";
    
    
    [self.manager GET:@"http://dis.myzaker.com/api/list_discussion.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSArray *items = [ZKRCommentCellItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        //        ZKRCommentCellItem *item = items[0];
        //        NSLog(@"%@",item.title);
        
        [self.itemsArray addObjectsFromArray: [ZKRCommentCellItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]]];
        
        [self.tableView reloadData];
        self.loadMoreCount++;
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}



#pragma mark - ---| tableview data source |---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRComDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.item = self.itemsArray[indexPath.row];
    
    cell.addButtonClickBlock = ^(){
        
        [self.navigationController presentViewController:[[ZKRLoginViewController alloc] init] animated:YES completion:nil];
    };
    
    return cell;
}

#pragma mark - ---| delegate |---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKRCommentCellItem *cellItem = self.itemsArray[indexPath.row];
    ZKRComDiscTopicController *topicVC = [[ZKRComDiscTopicController alloc] init];
    topicVC.view.backgroundColor = [UIColor whiteColor];
    
    topicVC.item = cellItem;
    
    
    topicVC.navigationItem.title = cellItem.title;
    
    [self.navigationController pushViewController:topicVC animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.itemsArray.count - 1) {
        [self loadMoreData];
    }
}

@end
