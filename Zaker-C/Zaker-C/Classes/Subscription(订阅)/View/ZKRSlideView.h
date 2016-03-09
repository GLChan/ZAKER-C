//
//  ZKRSlideView.h
//  Zaker-C
//
//  Created by GuangliChan on 16/2/17.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKRSlideViewButton;
@interface ZKRSlideView : UIView
@property (nonatomic, strong) void (^deallocBlock)() ;
 /** del button enable */
@property (nonatomic, assign) BOOL setupDelButtonEnable;

@property (weak, nonatomic) IBOutlet ZKRSlideViewButton *delButton;


@end
