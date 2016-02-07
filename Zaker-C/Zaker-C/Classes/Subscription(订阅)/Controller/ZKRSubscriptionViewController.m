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
#import "ZKRCollectionViewCell.h"
#import "UIBarButtonItem+CGLExtension.h"
#import "CycleView.h"

#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>

#import "ZKRMineTableController.h"
#import "ZKRRootTypeItem.h"
@interface ZKRSubscriptionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

 /** 整个界面的一个scrollView */
@property (nonatomic, weak) UIScrollView *scroll;
 /** 滚动新闻的scrollView */
@property (nonatomic, weak) UIScrollView *articleScroll;
 /** 内容分类的collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
 /** 内容分类的数组 */
@property (nonatomic, strong) NSMutableArray *typeArray;

@end

#pragma mark - ---| static |---
static NSString *ID = @"cell";
static NSString *requestURL = @"http://iphone.myzaker.com/zaker/follow_promote.php?";

@implementation ZKRSubscriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
     // 初始化主界面的scrollView
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
}

 /** 初始化头条图片轮播 */
- (void)setupRotateArticles
{
//    ZKRScrollPageView *pageView = [[ZKRScrollPageView alloc] init];
//    pageView.frame = CGRectMake(0, 0, CGLScreenW, 150);
//    
//    [self.scroll addSubview:pageView];
    CycleView *cycleView = [[CycleView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 200)];
    
    [self.scroll addSubview:cycleView];
}

 /** 初始化collectionView */
- (void)setupCollectionView
{
    //创建流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(cellWH, cellWH);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    
    //创建collectionView
    UICollectionView *contentTypeView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, CGLScreenW, 500) collectionViewLayout:flowLayout];

    contentTypeView.backgroundColor = CGLCommonBgColor;
    contentTypeView.scrollEnabled = NO;
    contentTypeView.dataSource = self;
    contentTypeView.delegate = self;
    
    // 注册cell
    [contentTypeView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    [self.scroll addSubview:contentTypeView];
    self.collectionView = contentTypeView;
    
    //计算整个页面的内容高度
    NSInteger count = _typeArray.count;
    NSInteger rows = (count - 1) / cols + 1;
    CGFloat collectionH = rows * cellWH;
    self.collectionView.cgl_height = collectionH;
    self.scroll.contentSize = CGSizeMake(0, collectionH + self.collectionView.cgl_y);
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewLongPress:)];
    longPress.minimumPressDuration = 1.0;
    [contentTypeView addGestureRecognizer:longPress];
    
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
    item.block_color = @"#d3d7d4";
    
    [_typeArray addObject:item];
}

#pragma mark - ---| event |---
 /** 监听左上角`我的`按钮点击 */
- (void)accountClick
{
    //根据storyBoard加载界面
    UIStoryboard *mineStoryBoard = [UIStoryboard storyboardWithName:NSStringFromClass([ZKRMineTableController class]) bundle:nil];
    
    ZKRMineTableController *mineVC = [mineStoryBoard instantiateInitialViewController];
    
    //push到我的界面
    [self.navigationController pushViewController:mineVC animated:YES];
    
}

 /** 监听右上角搜索按钮点击 */
- (void)searchClick
{
    CGLFunc
}

- (void)collectionViewLongPress:(UILongPressGestureRecognizer *)gesture
{
    //长按cell可以获得该cell的indexPath.section和indexPath.row值。并且注意的是，长按事件和单击事件并不会冲突，彼此没有任何关系，
    if (gesture.state == UIGestureRecognizerStateBegan) {
        //删除频道 , 退出编辑(未实现)
//        NSLog(@"UIGestureRecognizerStateBegan");
    } else if (gesture.state == UIGestureRecognizerStateChanged){
//        NSLog(@"UIGestureRecognizerStateChanged");
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
//        NSLog(@"UIGestureRecognizerStateEnded");
    }
    
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
