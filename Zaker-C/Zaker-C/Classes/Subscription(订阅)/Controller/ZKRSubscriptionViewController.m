//
//  ZKRSubscriptionViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/25.
//  Copyright © 2016年 GLChen. All rights reserved.
//
NSInteger const cols = 3;
CGFloat const margin = 1;
#define cellWH (CGLScreenW - (cols - 1) * margin)/cols

#import "ZKRSubscriptionViewController.h"
#import "ZKRArticleScrollView.h"
#import "ZKRCollectionViewCell.h"

#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>

#import "ZKRMineViewController.h"
#import "ZKRScrollPageView.h"
#import "ZKRRootTypeItem.h"
@interface ZKRSubscriptionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scroll;

@property (nonatomic, weak) UIScrollView *articleScroll;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSMutableArray *typeArray;
@end

@implementation ZKRSubscriptionViewController
static NSString *ID = @"cell";
static NSString *requestURL = @"http://iphone.myzaker.com/zaker/follow_promote.php?";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.backgroundColor = CGLCommonBgColor;
    mainScrollView.frame = self.view.bounds;
    [self.view addSubview:mainScrollView];
    _scroll = mainScrollView;
    _scroll.delegate = self;
    
    _scroll.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    //初始化轮播
    [self setupRotateArticles];
    
    //初始化 内容分类view
    [self loadData];
    [self setupCollectionView];
    

}

 /** 初始化导航栏 */
- (void)setupNav
{
    self.navigationItem.title = @"订阅";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"life_my_account" highImage:@"life_my_account" target:self action:@selector(accountClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"icon-search-o" highImage:@"icon-search-o" target:self action:@selector(searchClick)];
    
    self.navigationController.navigationBar.translucent = NO;
}

 /** 初始化头条图片轮播 */
- (void)setupRotateArticles
{
    
    ZKRScrollPageView *pageView = [[ZKRScrollPageView alloc] init];
    pageView.frame = CGRectMake(0, 0, CGLScreenW, 150);
    
    [self.scroll addSubview:pageView];
}

 /** 初始化collectionView */
- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(cellWH, cellWH);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    
    UICollectionView *contentTypeView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, CGLScreenW, 500) collectionViewLayout:flowLayout];

    contentTypeView.backgroundColor = CGLCommonBgColor;
    
    contentTypeView.scrollEnabled = NO;
    
    contentTypeView.dataSource = self;
    
    contentTypeView.delegate = self;
    
    // 注册cell
    [contentTypeView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    [self.scroll addSubview:contentTypeView];

    self.collectionView = contentTypeView;
    
    NSInteger count = _typeArray.count;
    NSInteger rows = (count - 1) / cols + 1;
    CGFloat collectionH = rows * cellWH;
    self.collectionView.cgl_height = collectionH;
    self.scroll.contentSize = CGSizeMake(0, collectionH + self.collectionView.cgl_y);
    
}

- (void)loadData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"rootBlocks" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
     /** 通过字典数组来创建一个模型数组 */
    _typeArray = [ZKRRootTypeItem mj_objectArrayWithKeyValuesArray:data[@"blocksData"]];
    //    NSLog(@"%@", self.typeArray);
    
    // 添加最后一个cell - 专门用来添加类型的cell
    ZKRRootTypeItem *item = [[ZKRRootTypeItem alloc] init];
    item.title = @"添加内容";
    item.pic = @"SubscriptionNightAddChannel";
    item.need_userinfo = @"NO";
    
    [_typeArray addObject:item];
    
    
}

#pragma mark - ---| event |---
- (void)accountClick
{
    CGLFunc
    UIStoryboard *mineStoryBoard = [UIStoryboard storyboardWithName:NSStringFromClass([ZKRMineViewController class]) bundle:nil];
    
    ZKRMineViewController *mineVC = [mineStoryBoard instantiateInitialViewController];
    
    [self.navigationController pushViewController:mineVC animated:YES];
}

- (void)searchClick
{
    CGLFunc
}


#pragma mark - ---| collection datasource |---
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.typeArray.count;
}

- (ZKRCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.typeArray[indexPath.row];
    return cell;
}

#pragma mark - ---| collection delegate |---
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - ---| scroll delegate |---
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGLFunc
}

@end
