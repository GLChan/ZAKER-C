//
//  ZKRFunCategoryController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRFunCategoryController.h"
#import "ZKRCategoryButton.h"
#import "AFHTTPSessionManager.h"
#import "ZKRFunCategoryItem.h"
#import "MJExtension.h"
#import "ZKRFunLocationController.h"

@interface ZKRFunCategoryController ()

@property (weak, nonatomic) IBOutlet ZKRCategoryButton *firCateButton;
@property (weak, nonatomic) IBOutlet ZKRCategoryButton *secCateButton;

@property (weak, nonatomic) IBOutlet ZKRCategoryButton *thrCateButton;
@property (weak, nonatomic) IBOutlet ZKRCategoryButton *fourCateButton;
@property (weak, nonatomic) IBOutlet ZKRCategoryButton *fifCateButton;

@property (weak, nonatomic) IBOutlet ZKRCategoryButton *sixCateButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSArray *itemsArray;
@end

@implementation ZKRFunCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"分类";
    
    
    [self loadData];
    
    [self.buttons enumerateObjectsUsingBlock:^(ZKRCategoryButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button addTarget:self action:@selector(categorySelected:) forControlEvents:UIControlEventTouchUpInside];
    }];
}
/**
 *  http://wl.myzaker.com/?_appid=iphone&_v=6.4.7&_version=6.46&c=category_list&city=%E5%B9%BF%E5%B7%9E
 */

- (void)loadData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"funCategory" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    /** 通过字典数组来创建一个模型数组 */
    self.itemsArray = [ZKRFunCategoryItem mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];

    [self.itemsArray enumerateObjectsUsingBlock:^(ZKRFunCategoryItem  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZKRCategoryButton *button = self.buttons[idx];
        button.item = obj;
        self.buttons[idx] = button;
//        NSLog(@"%@ %zd", obj.icon, idx);
    }];

    
    
}

- (void)categorySelected:(ZKRCategoryButton *)button
{
    ZKRFunCategoryItem *item = button.item;
    NSLog(@"%@", item.category);
}



- (IBAction)locationButtonClick:(UIButton *)sender {
    ZKRFunLocationController *vc = [[ZKRFunLocationController alloc] init];
    vc.navigationItem.title = @"选择你所在的城市";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        NSArray *array = @[self.firCateButton,
                     self.secCateButton,
                     self.thrCateButton,
                     self.fourCateButton,
                     self.fifCateButton,
                     self.sixCateButton];
        _buttons = [NSMutableArray arrayWithCapacity:array.count];
        [_buttons addObjectsFromArray:array];
    }
    return _buttons;
}

@end
