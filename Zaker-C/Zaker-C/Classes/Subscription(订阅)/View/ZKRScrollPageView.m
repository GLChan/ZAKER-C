//
//  ZKRScrollPageView.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRScrollPageView.h"
#import "ZKRArticleScrollView.h"
#import "ZKRRotationItem.h"

#import <UIButton+WebCache.h>
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>


@interface ZKRScrollPageView() <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *itemArray;

@property (nonatomic, strong) ZKRArticleScrollView *articleScroll;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, weak) NSTimer *timer;

@end

static NSString *requestURL = @"http://iphone.myzaker.com/zaker/follow_promote.php?";

@implementation ZKRScrollPageView

- (void)layoutSubviews
{
    // 1.pageControl单页的时候是否需要隐藏
    self.pageControl.hidesForSinglePage = YES;
    
    [self setupScrollView];
    
    [self setupPageControl];
    
    [self startTimer];
    
}

- (void)setupPageControl
{
    //添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    [pageControl setCurrentPage:1];
    
    pageControl.center = CGPointMake(self.center.x, self.articleScroll.cgl_height - pageControl.cgl_height - 5);
    
    //设置pageControl的样式
    [pageControl setValue:[UIImage imageNamed:@"HeadLineCurrentPageIndicator"] forKey:@"_currentPageImage"];
    [pageControl setValue:[UIImage imageNamed:@"HeadLinePageIndicator"] forKey:@"_pageImage"];
    
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
}

 /** 初始化滚动的view */
- (void)setupScrollView
{
    ZKRArticleScrollView *articleScroll = [[ZKRArticleScrollView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 200)];
    articleScroll.delegate = self;
    
    //网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"] = @"iphone";
    para[@"_version"] = @"6.45";
    
    //发送请求
    [manager GET:requestURL parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取dict
        NSDictionary *listDict = responseObject[@"data"];
        self.itemArray = [ZKRRotationItem mj_objectArrayWithKeyValuesArray:listDict[@"list"]];
        
        //根据模型数组初始化每个界面
        [articleScroll setupArticleWithItems:self.itemArray];
        
        //设置pageControl的数目
        self.pageControl.numberOfPages = self.itemArray.count;
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    self.articleScroll = articleScroll;
    [self addSubview:articleScroll];
}

- (void)startTimer
{
    // 返回一个自动开始执行任务的定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    
    // NSDefaultRunLoopMode(默认):同一时间只能执行一个任务
    // NSRunLoopCommonModes(公用):可以分配一定的时间处理其他任务
    // 作用:不管主线程做什么操作,都会分配一定的时候处理timer
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  停止定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
}

- (void)nextPage:(NSTimer *)timer
{
    // 计算下一页的页码
    // 超过最后一页
    NSUInteger page = self.pageControl.currentPage;
    self.pageControl.currentPage++;
    if(page ==  self.itemArray.count-1){
        self.pageControl.currentPage = 0;
    }
    
    page = self.pageControl.currentPage;
    // 滚到下一页
    [self.articleScroll setContentOffset:CGPointMake(page * CGLScreenW, 0) animated:YES];
}

#pragma mark - ---| scrollView delegate |---

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算页码
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = page;
}

/**
 *  即将开始拖拽scrollView时,停止定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 *  已经停止拖拽scrollView时,开启定时器
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

@end
