//
//  ZKRSubArticlesController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSubArticlesController.h"
#import "ZKRSubArticlesCell.h"
#import "ZKRRootTypeItem.h"
#import "ZKRHTTPSessionManager.h"
#import "UIImageView+WebCache.h"
#import "ZKRArticleItem.h"
#import "MJExtension.h"
#import "ZKRSubArticlesCell2.h"
#import "ZKRSubArticlesCell3.h"
#import "SVProgressHUD.h"
/**
 *  订阅 -> 频道界面
 */
@interface ZKRSubArticlesController()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *nearTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *farTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UISlider *pageSliderView;

@property (nonatomic, strong) ZKRHTTPSessionManager *manager;

@property (nonatomic, strong) NSArray *itemsArray;
@property (nonatomic, strong) NSMutableArray *pageArray;

 /** 顶部图片url */
@property (nonatomic, strong) NSMutableString *topImageURL;

@end

@implementation ZKRSubArticlesController
static NSString *SubArticlesCell  = @"SubArticlesCell";
static NSString *SubArticlesCell2 = @"SubArticlesCell2";
static NSString *SubArticlesCell3 = @"SubArticlesCell3";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SVProgressHUD show];
    [self loadData];
    
    [self setupCollectionView];
    
    self.pageSliderView.minimumValue = 0;
    [self.pageSliderView addTarget:self action:@selector(pageSliderViewDrag:) forControlEvents:UIControlEventTouchUpInside];
}

 /** 初始化collectionview */
- (void)setupCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 每一个网格的尺寸
    layout.itemSize                = self.contentView.frame.size;
    // 每一行之间的间距
    layout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing      = 0;
    layout.minimumInteritemSpacing = 0;
    // 上下左右的间距
    layout.sectionInset            = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:layout];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRSubArticlesCell class]) bundle:nil] forCellWithReuseIdentifier:SubArticlesCell];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRSubArticlesCell2 class]) bundle:nil] forCellWithReuseIdentifier:SubArticlesCell2];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRSubArticlesCell3 class]) bundle:nil] forCellWithReuseIdentifier:SubArticlesCell3];
    
    collectionView.delegate                       = self;
    collectionView.dataSource                     = self;
    collectionView.pagingEnabled                  = YES;
    collectionView.backgroundColor                = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView = collectionView;
    [self.contentView addSubview:self.collectionView];
}

#pragma mark - ---| loadData |---
 /** 加载数据 */
- (void)loadData
{
//    NSLog(@"%@", [self.item getAllPropertiesAndVaules]);
    
    self.manager = [ZKRHTTPSessionManager manager];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"]   = @"iphone";
    // udid 每台设备有个各自的udid
    para[@"_udid"]    = @"48E21014-9B62-48C3-B818-02F902C1619E";
    para[@"_net"]     = @"wifi";
    para[@"_version"] = @"6.46";
    
    
    [self.manager GET:self.item.api_url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [responseObject writeToFile:@"/Users/CGL/Desktop/articles.plist" atomically:YES];
        
        self.itemsArray = [ZKRArticleItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"articles"]];
        NSInteger count = self.itemsArray.count;

        NSMutableArray *page    = [NSMutableArray arrayWithCapacity:6];
        NSMutableArray *pages   = [NSMutableArray array];
        ZKRArticleItem *article = [[ZKRArticleItem alloc] init];
        for (int i = 0; i < count; ++i) {
            article = self.itemsArray[i];
            [page addObject:article];
            while (page.count == 6) {
                [pages addObject:page];
                page = [NSMutableArray arrayWithCapacity:6];
            }
        }
        self.pageArray = pages;
        
        ZKRArticleItem *fir_article = self.itemsArray[0];
        self.nearTimeLabel.text     = [fir_article.date setupCreatedAt];


        ZKRArticleItem *last_article = self.itemsArray[count - 1];
        self.farTimeLabel.text       = [last_article.date setupCreatedAt];
        
        
        self.topImageURL = responseObject[@"data"][@"ipadconfig"][@"pages"][0][@"diy"][@"bgimage_url"];
        self.pageSliderView.maximumValue = self.pageArray.count;
        
        
        [self.collectionView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - ---| data source |---
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRSubArticlesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SubArticlesCell forIndexPath:indexPath];
    cell.articlesArray       = self.pageArray[indexPath.row];
    cell.topImageURL         = self.topImageURL;
    cell.item                = self.item;
    
    ZKRSubArticlesCell2 *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:SubArticlesCell2 forIndexPath:indexPath];
    cell2.articlesArray        = self.pageArray[indexPath.row];
    cell2.topImageURL          = self.topImageURL;
    cell2.item                 = self.item;
    
    ZKRSubArticlesCell3 *cell3 = [collectionView dequeueReusableCellWithReuseIdentifier:SubArticlesCell3 forIndexPath:indexPath];
    cell3.articlesArray        = self.pageArray[indexPath.row];
    cell3.topImageURL          = self.topImageURL;
    cell3.item                 = self.item;
    
    if (indexPath.row % 3 == 0) {
        return cell;
    } else if (indexPath.row % 3 == 1){
        return cell2;
    } else {
        return cell3;
    }
}

#pragma mark - ---| delegate |---
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%zd", indexPath.row);
}
 /** 拖动页面 减速完毕 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageNum = scrollView.contentOffset.x / scrollView.cgl_width;
    [self.pageSliderView setValue:pageNum animated:YES];
}

#pragma mark - ---| event |---
 /** 拖动滑块 跳转页面 */
- (void)pageSliderViewDrag:(UISlider *)slider
{
    NSInteger page = (NSInteger)slider.value;
    
    [self.collectionView setContentOffset:CGPointMake(page * self.collectionView.cgl_width, 0) animated:YES];
}

 /** 返回按钮 */
- (IBAction)backButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [SVProgressHUD dismiss];
}



 /** 刷新按钮 */
- (IBAction)refreshButtonClick:(UIButton *)sender {

}



@end
