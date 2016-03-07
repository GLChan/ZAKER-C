//
//  ZKRSearchChannelSonController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/5.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSearchChannelSonController.h"
#import "ZKRChannelGroupItem.h"
#import "ZKRChannelCell.h"

/**
 *  频道分组的组成员界面
 */
@interface ZKRSearchChannelSonController ()<UISearchBarDelegate>

@end
static NSString *ChannelCell = @"ChannelCell";
@implementation ZKRSearchChannelSonController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRChannelCell class]) bundle:nil] forCellReuseIdentifier:ChannelCell];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [self setupNav];
}

/** 导航栏 */
- (void)setupNav
{
    CGFloat width = self.view.cgl_width - 60;
    
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, width, 40)];
    
    searchBar.delegate = self;
    searchBar.layer.cornerRadius = 20;
    searchBar.layer.masksToBounds = YES;
    [searchBar setPlaceholder:@"搜索频道                                                    "];
    
    // Get the instance of the UITextField of the search bar
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIBarButtonItem * searchButton = [[UIBarButtonItem alloc]initWithCustomView:searchBar];     self.navigationItem.rightBarButtonItem = searchButton;
    
}
- (void)setGroup:(ZKRChannelGroupItem *)group
{
    _group = group;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.group.sons.count;
}

- (ZKRChannelCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:ChannelCell];
    cell.item = self.group.sons[indexPath.row];
    return cell;
}

@end
