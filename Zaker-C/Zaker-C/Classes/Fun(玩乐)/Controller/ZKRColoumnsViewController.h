//
//  ZKRColoumnsViewController.h
//  Zaker-C
//
//  Created by GuangliChan on 16/2/19.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKRColoumnsViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *groupsArray;

/** 轮播图数组 */
@property (nonatomic, strong) NSString *cycleURLString;

@end
