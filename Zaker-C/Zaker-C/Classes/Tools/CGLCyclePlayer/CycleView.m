

#import "CycleView.h"
#import "CycleButon.h"
#import "CyclePageControl.h"

 /** 用了这些框架 */
#import "MJExtension.h"
#import "AFNetworking.h"
#import "UIButton+WebCache.h"

 /** 用了这个模型 */
#import "ZKRRotationItem.h"
#import "ZKRSubArticlesController.h"
#import "ZKRComDiscTopicController.h"

#define ScrollViewW self.scrollView.bounds.size.width
#define ScrollViewH self.scrollView.bounds.size.height

@interface CycleView()<UIScrollViewDelegate>

 /** 当前页码 */
@property (nonatomic, assign) NSUInteger currentPageIndex;
 /** scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;

 /** 三个按钮 */
@property (nonatomic, strong) CycleButon *leftButton;
@property (nonatomic, strong) CycleButon *centerButton;
@property (nonatomic, strong) CycleButon *rightButton;

 /** pageControl */
@property (nonatomic, strong) CyclePageControl *pageControl;

 /** 模型数组 */
@property (nonatomic, strong) NSMutableArray *itemArray;
 /** 模型数组长度 */
@property (nonatomic, assign) NSUInteger itemCount;

 /** 定时器 */
@property (nonatomic, weak) NSTimer *timer;

@end


@implementation CycleView

#pragma mark - ---| lazy load |---
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView                                = [[UIScrollView alloc] init];
        _scrollView.frame                          = self.bounds;
        _scrollView.delegate                       = self;
        _scrollView.pagingEnabled                  = YES;
        _scrollView.bounces                        = NO;
        _scrollView.backgroundColor                = [UIColor colorWithWhite:0 alpha:0];
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark - ---| 加载 |---
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 初始化按钮
    [self setupButtons];
    
    //加载数据
    [self loadData];
    
    //pageControl
    [self setupPageControl];
    
    //开启定时器
    [self startTimer];
}

/**
 *  加载数据 (想改请求的看这里😄)
 *  要是不知道怎么改的, 呵呵
 *
 */
static NSString *requestURL = @"http://iphone.myzaker.com/zaker/follow_promote.php";
- (void)loadData
{
    // 创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 需要传的参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"_appid"]           = @"iphone";
    parameters[@"_version"]         = @"6.45";
    
    //发送请求
    [manager GET:requestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //获取dict
        NSDictionary *listDict = responseObject[@"data"];
        self.itemArray = [ZKRRotationItem mj_objectArrayWithKeyValuesArray:listDict[@"list"]];
        
        //模型数组的数量
        _itemCount = self.itemArray.count;
        
        // 加载按钮数据
        [self loadButtonData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

 /** 初始化按钮 */
- (void)setupButtons
{
    // 默认当前页的序列为0
    self.currentPageIndex = 0;
    
    // 占位图
//    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    // 布局三个按钮
     /** left */
    _leftButton   = [[CycleButon alloc] initWithFrame:CGRectMake(0, 0, ScrollViewW, ScrollViewH)];
    [_leftButton setBackgroundImage:[[UIImage alloc] init] forState:UIControlStateNormal];
    [self.scrollView addSubview:_leftButton];

     /** center */
    _centerButton = [[CycleButon alloc] initWithFrame:CGRectMake(ScrollViewW, 0, ScrollViewW, ScrollViewH)];
    [_centerButton setBackgroundImage:[[UIImage alloc] init] forState:UIControlStateNormal];
    [self.scrollView addSubview:_centerButton];

     /** right */
    _rightButton  = [[CycleButon alloc] initWithFrame:CGRectMake(ScrollViewW * 2, 0, ScrollViewW, ScrollViewH)];
    [_rightButton setBackgroundImage:[[UIImage alloc] init] forState:UIControlStateNormal];
    [self.scrollView addSubview:_rightButton];
    
     /** 设置scrollView的内容尺寸与偏移量 */
    self.scrollView.contentSize   = CGSizeMake(3 * ScrollViewW, ScrollViewH);
    self.scrollView.contentOffset = CGPointMake(ScrollViewW, 0);
    
}

 /** pageControl */
- (void)setupPageControl
{
    CyclePageControl *pageControl = [[CyclePageControl alloc] init];
    pageControl.center            = CGPointMake(ScrollViewW * 0.5, ScrollViewH - 8);
    
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}

 /** 网络请求发送成功的时候才会加载按钮数据 (第一次加载图片想换也要改😂)*/
- (void)loadButtonData
{
    NSUInteger leftPageIndex   = _itemCount - 1;
    NSUInteger centerPageIndex = 0;
    NSUInteger rightPageIndex  = 1;
    
    //加载三个按钮 (三个按钮的模型要先赋值再传,要不然字体会还原本来的状态,得滚动之后才会变成自定义的样子)
     /** 左边按钮 */
    _leftButton.item = self.itemArray[leftPageIndex];
    [self setButton:_leftButton withItem:_leftButton.item];
    
     /** 中间按钮 */
     _centerButton.item = self.itemArray[centerPageIndex];
    [self setButton:_centerButton withItem:_centerButton.item];
    // 中间按钮的点击事件
    [_centerButton addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
     /** 右边按钮 */
     _rightButton.item = self.itemArray[rightPageIndex];
    [self setButton:_rightButton withItem:_rightButton.item];
    
     /** pageControl */
    _pageControl.numberOfPages = _itemCount;
}

 /** 重新加载按钮(会经常调用) */
- (void)reloadButton
{
    CGFloat offsetX = self.scrollView.contentOffset.x;
    
    if (_itemCount == 0) {
        return;
    }
    
    if (offsetX > ScrollViewW ) { // 向右滑动 ▶️
        _currentPageIndex  = (_currentPageIndex + 1) % _itemCount;
        _centerButton.item = self.itemArray[_currentPageIndex];
        [self setButton:_centerButton withItem:_centerButton.item];
        
    } else if (offsetX < ScrollViewW) { // 向左滑动
        _currentPageIndex  = (_currentPageIndex + _itemCount - 1) % _itemCount;
        _centerButton.item = self.itemArray[_currentPageIndex];
        [self setButton:_centerButton withItem:_centerButton.item];
    }
    
    // 重新加载左右两边的图片
    NSUInteger leftIndex, rightIndex;
    // 左边
    leftIndex        = (_currentPageIndex + _itemCount - 1) % _itemCount;
    _leftButton.item = self.itemArray[leftIndex];
    [self setButton:_leftButton withItem:_leftButton.item];

    // 右边
    rightIndex        = (_currentPageIndex + 1) % _itemCount;
    _rightButton.item = self.itemArray[rightIndex];
    [self setButton:_rightButton withItem:_rightButton.item];
}

 /** 通过模型加载按钮 (想让按钮显示什么内容看这里😂)*/
- (void)setButton:(CycleButon *)button withItem:(ZKRRotationItem *)item
{
    [button sd_setBackgroundImageWithURL:[NSURL URLWithString:item.promotion_img] forState:UIControlStateNormal];
    [button setTitle:item.title forState:UIControlStateNormal];
    [button sd_setImageWithURL:[NSURL URLWithString:item.tag_info[@"image_url"]] forState:UIControlStateNormal];
}

 /** 开启定时器 */
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark - ---| event |---
/**
 *  点击图片要发生的事件写在这里面
 */
- (void)centerButtonClick:(CycleButon *)button
{
//    NSLog(@"%@", [button.item getAllPropertiesAndVaules]);
    // 判断类型跳转到不同的控制器
    if ([button.item.type isEqualToString:@"block"]){ // 3. 频道 block
        
//        ZKRSubArticlesController *articleVC = [[ZKRSubArticlesController alloc] init];
//        articleVC.block_api_url = button.item.block_api_url;
//        [[self navController] pushViewController:articleVC animated:YES];
        
    } else if ([button.item.type isEqualToString:@"discussion"]){// discussion 讨论/话题
        
//        ZKRComDiscTopicController *topicVC = [[ZKRComDiscTopicController alloc] init];
//        topicVC.discussion_api_url = button.item.discussion_api_url;
//        [[self navController] pushViewController:topicVC animated:YES];
        
    } else if ([button.item.type isEqualToString:@"topic"]) {// topic 夜读 / 专题
        
            
    } else { // 文章
        
    }
    
}

 /** 定时器每隔一段时间调用的方法 */
- (void)nextPage:(NSTimer *)timer
{
    // 偏移到最后一张图片, 并附上动画 ,动画完成之后会调用`scrollViewDidEndScrollingAnimation`方法(为了让scrollView偏移回显示中间的一个)
    [_scrollView setContentOffset:CGPointMake(ScrollViewW * 2, 0) animated:YES];
}

/**
 *  停止定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
    
}
#pragma mark - ---| scrollview delegate |---
 /** 在定时器所调用的下一页是个动画, 所以在动画结束的时候也要重新加载按钮,重置偏移量等 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self reloadButton];
    
    // 滚动后的偏移量再次设置为显示中间的图片
    [scrollView setContentOffset:CGPointMake(ScrollViewW, 0) animated:NO];
    
    // 设置分页
    _pageControl.currentPage = _currentPageIndex;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadButton];
    
    // 滚动后的偏移量再次设置为显示中间的图片
    [scrollView setContentOffset:CGPointMake(ScrollViewW, 0) animated:NO];
    
    // 设置分页
    _pageControl.currentPage = _currentPageIndex;
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
