//
//  ZKRSearchChoiceController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSearchChoiceController.h"
#import "AFHTTPSessionManager.h"
#import "ZKRSearchChoiceTopItem.h"
#import "MJExtension.h"
#import "UIButton+WebCache.h"
#import "ZKRSearchChoiceTopView.h"
#import "ZKRSearchChoiceChannelItem.h"
#import "ZKRSearchChoiceChannelCell.h"
#import "SVProgressHUD.h"
/**
 *  订阅 -> 搜索 -> 精选
 */
@interface ZKRSearchChoiceController ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSArray *itemsArray;

@property (nonatomic, weak) ZKRSearchChoiceTopView *topView;

@property (nonatomic, strong) NSMutableArray *topButtonsArray;
@property (nonatomic, strong) NSMutableArray *channelsArray;

@end

static NSString *ChoiceChannelCell = @"ChoiceChannelCell";
@implementation ZKRSearchChoiceController
#pragma mark - ---| lazy load |---



- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _manager = manager;
    }
    return _manager;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SVProgressHUD show];
    
    [self setupTopView];
    [self loadTopData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     /** 设置头部视图不能写在这= = */
//    [self loadTopData];
//    [self setupTopView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRSearchChoiceChannelCell class]) bundle:nil] forCellReuseIdentifier:ChoiceChannelCell];
    self.tableView.rowHeight = 100;
    // cell底部分割线去除
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    // 加载精选频道
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self loadChoiceData];
    
}

#pragma mark - ---| 加载视图 |---
 /** 加载顶部视图 */
- (void)setupTopView
{
    self.topView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZKRSearchChoiceTopView class]) owner:nil options:nil].lastObject;
    self.topView.frame = CGRectMake(0, 0, 375, 150);
    
    self.tableView.tableHeaderView =  self.topView;
//    self.tableView.cgl_y = 200;
    
}

#pragma mark - ---| 加载数据 |---
 /** 顶部数据加载 */
- (void)loadTopData
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"] = @"iphone";
    
    [self.manager GET:@"http://iphone.myzaker.com/zaker/find_promotion.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSMutableArray *array = [ZKRSearchChoiceTopItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"][0]];
//        [array addObjectsFromArray:[ZKRSearchChoiceTopItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"][1]]];
//        
//        self.itemsArray = array;
//        
//        for (int i = 0; i < self.itemsArray.count; ++i) {
//            ZKRSearchChoiceTopItem *item = self.itemsArray[i];
//            UIButton *button = self.topButtonsArray[i];
//            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:item.promotion_img] forState:UIControlStateNormal];
//        }
//        
//        self.topView.items = self.itemsArray;
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

 /** 加载精选频道数据 */
- (void)loadChoiceData
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"] = @"iphone";
    para[@"_version"] = @"6.46";
    
    [self.manager GET:@"http://iphone.myzaker.com/zaker/find.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.channelsArray = [ZKRSearchChoiceChannelItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - ---| data source |---
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 20)];
    view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 3, 50, 15)];
    [view addSubview:label];
    label.textColor = [UIColor lightGrayColor];
    label.text = @"精选";
    return view;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}

- (ZKRSearchChoiceChannelCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRSearchChoiceChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:ChoiceChannelCell];
    
    cell.item = self.channelsArray[indexPath.row];
    
    return cell;
}

@end
