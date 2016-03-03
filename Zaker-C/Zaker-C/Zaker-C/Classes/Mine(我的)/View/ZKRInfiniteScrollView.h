//
//  ZKRInfiniteScrollView.h
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZKRInfiniteScrollView;

@protocol ZKRInfiniteScrollViewDelegate <NSObject>
@optional
- (void)infiniteScrollView:(ZKRInfiniteScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index;
@end

typedef NS_ENUM(NSInteger, ZKRInfiniteScrollViewDirection) {
    /** 水平滚动（左右滚动） */
    ZKRInfiniteScrollViewDirectionHorizontal = 0,
    /** 垂直滚动（上下滚动） */
    ZKRInfiniteScrollViewDirectionVertical
};

@interface ZKRInfiniteScrollView : UIView
/** 图片数据(里面存放UIImage对象) */
@property (nonatomic, strong) NSArray *images;
/** 图片数据*/
//@property (nonatomic, strong) NSArray *imageUrls;
/** 滚动方向 */
@property (nonatomic, assign) ZKRInfiniteScrollViewDirection direction;
/** 代理 */
@property (nonatomic, weak) id<ZKRInfiniteScrollViewDelegate> delegate;

@property (nonatomic, weak, readonly) UIPageControl *pageControl;

@end