//
//  ZKRInfiniteScrollView.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRInfiniteScrollView.h"
#import <objc/runtime.h>
@interface ZKRInfiniteScrollView() <UIScrollViewDelegate>
/** 页码显示 */
@property (nonatomic, weak) UIPageControl *pageControl;
/** 显示具体内容 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation ZKRInfiniteScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        // 取消边缘的弹簧效果
        scrollView.bounces = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 添加3个UIImageView
        for (NSInteger i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)]];
            
            imageView.contentMode = UIViewContentModeTop;
            [scrollView addSubview:imageView];
        }
        
        // pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [pageControl setValue:[UIImage imageNamed:@"Dot-o-gray-5"] forKeyPath:@"_pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"Dot-gray-5"] forKeyPath:@"_currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        // 开启定时器
//        [self startTimer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 整体尺寸
    CGFloat scrollViewW = self.bounds.size.width;
    CGFloat scrollViewH = self.bounds.size.height;
    
    // scrollView
    self.scrollView.frame = self.bounds;
    if (self.direction == ZKRInfiniteScrollViewDirectionHorizontal) {
        self.scrollView.contentSize = CGSizeMake(3 * scrollViewW, 0);
    } else {
        self.scrollView.contentSize = CGSizeMake(0, 3 * scrollViewH);
    }
    
    // UIImageView
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        if (self.direction == ZKRInfiniteScrollViewDirectionHorizontal) {
            imageView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        } else {
            imageView.frame = CGRectMake(0, i * scrollViewH, scrollViewW, scrollViewH);
        }
    }
    
    // pageControl
    self.pageControl.center = CGPointMake(self.cgl_width * 0.5, self.cgl_height - self.pageControl.cgl_height);
    
    // 更新内容
    [self updateContent];
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    // 总页数
    self.pageControl.numberOfPages = images.count;
}
//
//- (void)setImageUrls:(NSArray *)imageUrls
//{
//    _imageUrls = imageUrls;
//
//    // 总页数
//    self.pageControl.numberOfPages = imageUrls.count;
//}

#pragma mark - 监听点击
- (void)imageClick:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didSelectItemAtIndex:)]) {
        [self.delegate infiniteScrollView:self didSelectItemAtIndex:tap.view.tag];
    }
}

#pragma mark - 其他
/**
 *  更新所有UIImageView的内容，并且重置scrollView.contentOffset.x == 1倍宽度
 */
- (void)updateContent
{
    // 当前页码
    NSInteger page = self.pageControl.currentPage;
    
    // 更新所有UIImageView的内容
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        // 图片索引
        NSInteger index = 0;
        if (i == 0) { // 左边的imageView
            index = page - 1;
        } else if (i == 1) { // 中间的imageView
            index = page;
        } else { // 右边的imageView
            index = page + 1;
        }
        // 处理特殊情况
        if (index == -1) { // 变成最后一张
            index = self.images.count - 1;
        } else if (index == self.images.count) { // 变为最前面一张
            index = 0;
        }
        imageView.image = self.images[index];
        // 设置index为tag
        imageView.tag = index;
    }
    
    // 重置scrollView.contentOffset.x == 1倍宽度
    if (self.direction == ZKRInfiniteScrollViewDirectionHorizontal) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    }
}

#pragma mark - 定时器
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage
{
    if (self.direction == ZKRInfiniteScrollViewDirectionHorizontal) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width, 0) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y + self.scrollView.frame.size.height) animated:YES];
    }
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  只要scrollView滚动，就会调用这个方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 求出显示在最中间的imageView
    UIImageView *destImageView = nil;
    CGFloat minDelta = MAXFLOAT;
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        CGFloat delta = 0;
        if (self.direction == ZKRInfiniteScrollViewDirectionHorizontal) {
            delta = ABS(self.scrollView.contentOffset.x - imageView.frame.origin.x);
        } else {
            delta = ABS(self.scrollView.contentOffset.y - imageView.frame.origin.y);
        }
        if (delta < minDelta) {
            minDelta = delta;
            destImageView = imageView;
        }
    }
    
    // imageView的tag就是显示在最中间的图片索引
    self.pageControl.currentPage = destImageView.tag;
}

/**
 *  当scrollView停止滚动的时候调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
    
//    [self startTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    [self updateContent];
}

@end
