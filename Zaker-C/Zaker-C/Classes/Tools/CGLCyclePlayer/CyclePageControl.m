//
//  CyclePageControl.m
//  CycleTest
//
//  Created by GuangliChan on 16/2/2.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "CyclePageControl.h"

@interface CyclePageControl()

@property (nonatomic, assign) CGFloat dotSpacing;
@property (nonatomic, assign) CGFloat dotSize;
@end


@implementation CyclePageControl
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dotSize = 10.0f;
        _dotSpacing = 10.0f;
        
        [self setValue:[UIImage imageNamed:@"HeadLineCurrentPageIndicator"] forKey:@"_currentPageImage"];
        [self setValue:[UIImage imageNamed:@"HeadLinePageIndicator"] forKey:@"_pageImage"];
        
        [self setHidesForSinglePage:YES];
        
    }
    return self;
}



@end



