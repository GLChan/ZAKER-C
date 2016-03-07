//
//  ZKRSubSearchController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSubSearchController.h"
#import "CGLTitleButton.h"
#import "ZKRAccountBarButtonItem.h"
#import "ZKRSearchChannelController.h"
#import "ZKRSearchChoiceController.h"

/**
 *  订阅 -> 右上角搜索
 */
@interface ZKRSubSearchController () <UIScrollViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) UIView *titleScrollView;

@property (nonatomic, strong) UIView *titleBottomView;

@property (nonatomic, weak) UIView *underLine;
/** 之前被点击的按钮 */
@property (nonatomic, weak) CGLTitleButton *previousClickedTitleButton;

@property (nonatomic, weak) UIScrollView *mainScrollView;

@end

@implementation ZKRSubSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    //scrollView
    [self setupScrollView];
    
    [self setupTitleView];
    
    //初始化所有子控制器(将所有子控制器添加到精华的控制器里面)
    [self setupAllChildView];
}

/** 导航栏 */
- (void)setupNav
{
    CGFloat width = self.view.cgl_width - 60;
    
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, width, 40)];
    
    searchBar.delegate = self;
    searchBar.layer.cornerRadius = 20;
    searchBar.layer.masksToBounds = YES;
    [searchBar setPlaceholder:@"搜索文章和频道                                                "];
    
    // Get the instance of the UITextField of the search bar
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIBarButtonItem * searchButton = [[UIBarButtonItem alloc]initWithCustomView:searchBar];     self.navigationItem.rightBarButtonItem = searchButton;

}

/** Main scrollView */
- (void)setupScrollView
{
    UIScrollView *mainScrollView   = [[UIScrollView alloc] init];
    mainScrollView.frame           = self.view.bounds;
    mainScrollView.backgroundColor = [UIColor whiteColor];
    // 关闭弹簧效果
    mainScrollView.bounces         = NO;
    mainScrollView.delegate        = self;
    
    self.mainScrollView            = mainScrollView;
    
    [self.view addSubview:mainScrollView];
    
}

/** setupAllChildView */
- (void)setupAllChildView
{
    [self addChildViewController:[[ZKRSearchChoiceController alloc] init]];
    [self addChildViewController:[[ZKRSearchChannelController alloc] init]];
    
    
    //子控制器的数目
    NSUInteger count = self.childViewControllers.count;
    // 这里是通过循环一次性添加所有子控制器的view到ScrollView中
    // 遍历给每个控制器的view定位
    for (NSUInteger i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * CGLScreenW, 35, CGLScreenW, CGLScreenH-99);
        [self.mainScrollView addSubview:vc.view];
    }
    
    self.mainScrollView.contentSize                    = CGSizeMake(count * CGLScreenW, 0);
    self.mainScrollView.pagingEnabled                  = YES;
    self.mainScrollView.showsVerticalScrollIndicator   = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    
    /** 不要自动调整内边距 */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupChildViewControllerForScrollView:0];
    
}

/** 顶部标题栏 */
- (void)setupTitleView
{
    UIView *titleScrollView   = [[UIView alloc] init];
    titleScrollView.frame           = CGRectMake(0, 0, self.view.cgl_width, 35);
    titleScrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.98];
    self.titleScrollView            = titleScrollView;
    
    UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.frame = CGRectMake(0, titleScrollView.cgl_height - 0.5, self.view.cgl_width, 1);
    titleBottomView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.titleBottomView = titleBottomView;
    
    [self.view addSubview:titleBottomView];
    [self.view addSubview:titleScrollView];
    
    [self setupTitleButtons];
}

/** 初始化标题按钮 */
- (void)setupTitleButtons
{
    NSArray *titleArray = @[@"精选", @"频道"];
    NSUInteger count    = titleArray.count;
    
    //按钮大小
    CGFloat width  = self.titleScrollView.cgl_width / count;
    CGFloat height = self.titleScrollView.cgl_height;
    
    
    //添加按钮
    for (NSUInteger i = 0; i < count; i++) {
        CGLTitleButton *button = [[CGLTitleButton alloc] init];
        button.frame           = CGRectMake(i * width, 0, width, height);
        button.tag             = i;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:button];
    }
    
    [self setupUnderLine];
}

/** 加载按钮 */
- (void)setupUnderLine
{
    //获取第一个按钮
    CGLTitleButton *firstButton = self.titleScrollView.subviews.firstObject;
    
    CGFloat height              = 2;
    UIView *underView           = [[UIView alloc] init];
    underView.frame             = CGRectMake(0, firstButton.cgl_height - height, firstButton.cgl_width, height);
    underView.backgroundColor   = [firstButton titleColorForState:UIControlStateSelected];
    
    [firstButton addSubview:underView];
    self.underLine = underView;
    
    // 加载第一次的时候第一个按钮默认为选中
    firstButton.selected            = YES;
    self.previousClickedTitleButton = firstButton;
    
    [firstButton.titleLabel sizeToFit];
    underView.cgl_centerX = firstButton.cgl_centerX;
}

#pragma mark - ---| event |---

/** 按钮点击监听方法 */
- (void)titleButtonClick:(CGLTitleButton *)titleButton
{
    // 重复点击按钮
    if (self.previousClickedTitleButton == titleButton) {
        //        [[NSNotificationCenter defaultCenter] postNotificationName:CGLTitleButtonDidRepeatClickNotification object:nil];
    }
    
    self.previousClickedTitleButton.selected = NO;// UIControlStateNormal -> darkGrayColor
    titleButton.selected                     = YES;// UIControlStateSelected -> redColor
    self.previousClickedTitleButton          = titleButton;
    
    NSInteger index = titleButton.tag;
    
    //当按钮点击的时候,将underLine也跟随移动位置
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.cgl_centerX = titleButton.cgl_centerX;
        
        CGFloat offsetX = titleButton.tag * self.mainScrollView.cgl_width;
        self.mainScrollView.contentOffset = CGPointMake(offsetX, self.mainScrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self setupChildViewControllerForScrollView:index];
    }];
    
}

/**
 *  将index位置的子控制器的view添加到ScrollView上
 */
- (void)setupChildViewControllerForScrollView:(NSInteger)index
{
    UIViewController *vc = self.childViewControllers[index];
    
    if (vc.isViewLoaded) return;
    
    vc.view.cgl_x      = index * self.mainScrollView.cgl_width;
    vc.view.cgl_y      = 0;
    vc.view.cgl_width  = self.mainScrollView.cgl_width;
    vc.view.cgl_height = self.mainScrollView.cgl_height;
    [self.mainScrollView addSubview:vc.view];
}


#pragma mark - ---| scrollview delegate |---
/** 监听减速 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //根据偏移量计算页码
    NSUInteger page = scrollView.contentOffset.x / scrollView.cgl_width;
    
    CGLTitleButton *button = self.titleScrollView.subviews[page];
    
    [self titleButtonClick:button];
}


@end
