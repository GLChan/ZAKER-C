//
//  ZKRHotViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/25.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRHotViewController.h"
#import "UIBarButtonItem+CGLExtension.h"
#import "ZKRAccountBarButtonItem.h"


#import "MJExtension.h"
#import "ZKRHotGroupItem.h"
#import "ZKRHotCellItem.h"
#import "ZKRHotTableViewCell.h"
#import "ZKRRefreshHeader.h"

@interface ZKRHotViewController ()
@property (nonatomic, strong) NSMutableArray *itemsArray;

@property (nonatomic, strong) ZKRHotGroupItem *groupItem;

@property (nonatomic, strong) NSMutableDictionary *data;
@end

static NSString *CGLHotCellID = @"CGLHotCellID";

@implementation ZKRHotViewController
#pragma mark - ---| lazy load |---
- (NSMutableArray *)itemsArray
{
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 加载导航栏
    [self setupNav];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRHotTableViewCell class]) bundle:nil] forCellReuseIdentifier:CGLHotCellID];
    
    self.tableView.rowHeight = 100;
    // cell底部分割线去除
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    [self setupRefresh];
    
    [self loadPlist];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [ZKRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewCell)];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewCell
{
    [self.tableView.mj_header endRefreshing];
}

- (void)setupNav
{
    self.navigationItem.title = @"热点";
    //左
    self.navigationItem.leftBarButtonItem = [ZKRAccountBarButtonItem itemWithImage:@"life_my_account" highImage:@"life_my_account" navigationController:self.navigationController];
    // 右
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"DailyHot_PreferencesButton" highImage:@"DailyHot_PreferencesButton_inDark" target:self action:@selector(dailyHotClick)];
}

#pragma mark - ---| loadData |---
- (void)loadPlist
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"hot" ofType:@"plist"];
    self.data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//        NSLog(@"%@", self.data);
    [self loadData];
}

/**
 *  fun
 */
- (void)loadData
{
    // group 对象
    ZKRHotGroupItem *groupItem = [ZKRHotGroupItem mj_objectWithKeyValues:self.data[@"data"][@"articles"][0][@"article_group"]];
    
    ZKRHotCellItem *cellItem = [[ZKRHotCellItem alloc] init];
    
    NSMutableArray *cellItems = [NSMutableArray arrayWithCapacity:groupItem.items.count];
    
    for (NSDictionary *dict in groupItem.items) {
        cellItem = [ZKRHotCellItem mj_objectWithKeyValues:dict[@"article"]];
        [cellItems addObject:cellItem];

    }
    
    groupItem.cellItems = cellItems;
    self.groupItem = groupItem;
    // 保存到数组
    [self.itemsArray addObject:self.groupItem];
    
    
    /** cell */
    NSMutableArray *cellsArray = [ZKRHotCellItem mj_objectArrayWithKeyValuesArray:self.data[@"data"][@"articles"]];
    
    // 将不是单个文章的对象删除(group)
    for (int i = 0; i < cellsArray.count; i++) {
        ZKRHotCellItem *item = cellsArray[i];
        if ([item.type isEqualToString:@"article_group"]) {
            [cellsArray removeObjectAtIndex:i];
            
        }
//        NSLog(@"%@", item.thumbnail_medias[0][@"url"]);
    }
    
    [self.itemsArray addObjectsFromArray:cellsArray];
    
//    NSLog(@"%@", self.itemsArray);
}


#pragma mark - ---| event |---
- (void)dailyHotClick
{
    CGLFunc
}

#pragma mark - ---| table View data source |---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CGLHotCellID];
    
    cell.cellItem = self.itemsArray[indexPath.row + 1];
    
    return cell;
}


@end
