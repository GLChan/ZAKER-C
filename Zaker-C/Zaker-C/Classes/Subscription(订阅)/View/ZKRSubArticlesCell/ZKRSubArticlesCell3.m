//
//  ZKRSubArticlesCell3.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/1.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSubArticlesCell3.h"
#import "UIImageView+WebCache.h"
#import "ZKRRootTypeItem.h"
#import "ZKRArticleItem.h"
#import "ZKRArticleViewController.h"

@interface ZKRSubArticlesCell3()
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

/** top */
@property (weak, nonatomic) IBOutlet UIView *contentView1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1HeightConstranint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *artiImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleConstraint;

/** mid top left*/
@property (weak, nonatomic) IBOutlet UIView *contentView2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel2;
/** mid top right */
@property (weak, nonatomic) IBOutlet UIView *contentView3;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel3;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel3;

/** mid bottom */
@property (weak, nonatomic) IBOutlet UIView *contentView4;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel4;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel4;

/** bottom left */
@property (weak, nonatomic) IBOutlet UIView *contentView5;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel5;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel5;
/** bottom right */
@property (weak, nonatomic) IBOutlet UIView *contentView6;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel6;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel6;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *authors;
@property (nonatomic, strong) NSArray *contentViews;

@end

@implementation ZKRSubArticlesCell3

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.authorLabel1.textColor = [UIColor clearColor];
    
    self.artiImageView.clipsToBounds = YES;
}

- (void)setArticlesArray:(NSArray *)articlesArray
{
    _articlesArray = articlesArray;
    
    NSInteger count = articlesArray.count;
    ZKRArticleItem *article = [[ZKRArticleItem alloc] init];
    UILabel *titleLabel = [[UILabel alloc] init];
    UILabel *authorLabel = [[UILabel alloc] init];
    
    for (int i = 0; i < count; ++i) {
        article = articlesArray[i];
        if (article.title) {
            titleLabel = self.titles[i];
            titleLabel.text = article.title;
        }
        if (article.auther_name) {
            authorLabel = self.authors[i];
            //            authorLabel.text = article.auther_name;
            authorLabel.text = [NSString stringWithFormat:@"%@  %@", article.auther_name, [article.date setupCreatedAt]];
        }
        if (i == 0) {
            if (article.thumbnail_pic) {
                [self.artiImageView sd_setImageWithURL:[NSURL URLWithString:article.thumbnail_pic]];
                self.titleConstraint.constant = 10;
                self.view1HeightConstranint.constant = 230;
            } else {
                [self.artiImageView sd_setImageWithURL:[NSURL URLWithString:@""]];
                self.titleConstraint.constant = 60;
                self.view1HeightConstranint.constant = 150;
            }
            if ([article.open_type isEqualToString:@"discussion"]) {
                [self.typeImageView sd_setImageWithURL:[NSURL URLWithString:article.icon_url]];
                self.typeImageView.hidden = NO;
            } else {
                [self.typeImageView sd_setImageWithURL:[NSURL URLWithString:@""]];
                self.typeImageView.hidden = YES;
            }
        }
        
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =  [touches anyObject];
    
    __block ZKRArticleItem *article = [[ZKRArticleItem alloc] init];
    [self.contentViews enumerateObjectsUsingBlock:^(id  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint curP = [touch locationInView:view];
        if ([view pointInside:curP withEvent:event]) {
            article = self.articlesArray[idx];
            ZKRArticleViewController *vc = [[ZKRArticleViewController alloc] init];
            vc.item = self.articlesArray[idx];
            vc.item.block_color = self.item.block_color;
            [[view navController] pushViewController:vc  animated:YES];
            
        }
        
    }];
    //    NSLog(@"%@", article.title);
}
- (void)setItem:(ZKRRootTypeItem *)item
{
    _item = item;
    self.artiImageView.backgroundColor = [UIColor colorWithHexString:self.item.block_color];
}

/** 顶部标题图片加载 */
- (void)setTopImageURL:(NSString *)topImageURL
{
    _topImageURL = topImageURL;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.topImageURL]];
    //    NSLog(@"%@", self.topImageURL);
    
}

#pragma mark - ---| lazy load |---
- (NSArray *)titles
{
    if (!_titles) {
        NSArray *titles = @[self.titleLabel1,
                            self.titleLabel2,
                            self.titleLabel3,
                            self.titleLabel4,
                            self.titleLabel5,
                            self.titleLabel6];
        _titles = titles;
    }
    return _titles;
}

- (NSArray *)authors
{
    if (!_authors) {
        NSArray *authors = @[ self.authorLabel1,
                              self.authorLabel2,
                              self.authorLabel3,
                              self.authorLabel4,
                              self.authorLabel5,
                              self.authorLabel6];
        _authors = authors;
    }
    return _authors;
}

- (NSArray *)contentViews
{
    if (!_contentViews) {
        NSArray *contentViews = @[ self.contentView1,
                                   self.contentView2,
                                   self.contentView3,
                                   self.contentView4,
                                   self.contentView5,
                                   self.contentView6];
        _contentViews = contentViews;
    }
    return _contentViews;
}

@end
