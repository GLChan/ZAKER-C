//
//  ZKRAtricleShowMediaController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/8.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRAtricleShowMediaController.h"
#import "ZKRArticleViewCell.h"

@interface ZKRAtricleShowMediaController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *mainView;


@property (nonatomic, weak) UICollectionView *collectionView;
@end
static NSString *ArticleViewCell = @"ArticleViewCell";
@implementation ZKRAtricleShowMediaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 用collectionview显示图片
    [self setupCollectionView];
    
}

- (void)setupCollectionView
{
    //创建流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize                = CGSizeMake(self.mainView.cgl_width, self.mainView.cgl_height);
    flowLayout.minimumLineSpacing      = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
    
    //创建collectionView
    UICollectionView *mediasView = [[UICollectionView alloc] initWithFrame:self.mainView.bounds collectionViewLayout:flowLayout];
    
    mediasView.dataSource                     = self;
    mediasView.delegate                       = self;
    mediasView.pagingEnabled                  = YES;
    mediasView.showsHorizontalScrollIndicator = NO;
    mediasView.bounces                        = NO;
    
    mediasView.contentOffset = CGPointMake(self.mainView.cgl_width * self.currentIndex, 0);
    // 注册cell
    [mediasView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRArticleViewCell class]) bundle:nil] forCellWithReuseIdentifier:ArticleViewCell];
    
    [self.mainView addSubview:mediasView];
    self.collectionView = mediasView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ---| collection dataSource |---

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.medias.count;
}

- (ZKRArticleViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKRArticleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ArticleViewCell forIndexPath:indexPath];
//    cell.media = self.medias[indexPath.row][@"m_url"];
    cell.media = self.medias[indexPath.row][@"url"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self backButtonClick:[UIButton buttonWithType:UIButtonTypeCustom]];
}

#pragma mark - ---| event|---
- (IBAction)backButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (IBAction)greatButtonClick:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
    } else {
        sender.selected = YES;
    }
}
- (IBAction)shareButtonClick:(UIButton *)sender {
}
- (IBAction)downloadButtonClick:(UIButton *)sender {
}
@end
