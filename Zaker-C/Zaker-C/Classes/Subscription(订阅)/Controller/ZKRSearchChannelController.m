//
//  ZKRSearchChannelController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSearchChannelController.h"
#import "AFHTTPSessionManager.h"
#import "ZKRChannelGroupItem.h"
#import "ZKRChannelItem.h"
#import "MJExtension.h"
#import "ZKRSearchChannelCell.h"
#import "ZKRSearchChannelSonController.h"
/**
 *  订阅 -> 搜索 -> 频道
 */
@interface ZKRSearchChannelController ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableArray *channels;

@end
static NSString *ChannelsGroupCell = @"ChannelsGroupCell";
@implementation ZKRSearchChannelController
/**
 *  - 频道列表
 - http://iphone.myzaker.com/zaker/apps_v3.php?
 _appid=iphone&_version=6.46&m=1455789990
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRSearchChannelCell class]) bundle:nil] forCellReuseIdentifier:ChannelsGroupCell];
    self.tableView.rowHeight = 62;
    
    [self loadGroupsData];
}

- (void)loadGroupsData
{
    self.manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"] = @"iphone";
    para[@"_version"] = @"6.46";
    
    [self.manager GET:@"http://iphone.myzaker.com/zaker/apps_v3.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.groups = [ZKRChannelGroupItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        // 遍历数组 转换成频道item
        [self.groups enumerateObjectsUsingBlock:^(ZKRChannelGroupItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            self.channels = [ZKRChannelItem mj_objectArrayWithKeyValuesArray:obj.sons];
            obj.sons = self.channels;
            self.groups[idx] = obj;
        }];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - ---| tableview data source |---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;
}

- (ZKRSearchChannelCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRSearchChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:ChannelsGroupCell];
    
    cell.item = self.groups[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRSearchChannelSonController *sonVC = [[ZKRSearchChannelSonController alloc] init];
    sonVC.group = self.groups[indexPath.row];
    [self.navigationController pushViewController:sonVC animated:YES];
}

@end
