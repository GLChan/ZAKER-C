//
//  ZKRSearchChoiceController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/27.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRSearchChoiceController.h"
#import "AFHTTPSessionManager.h"
#import "ZKRSearchChoiceTopItem.h"
#import "MJExtension.h"
#import "UIButton+WebCache.h"

@interface ZKRSearchChoiceController ()

@property (nonatomic, strong) NSArray *itemsArray;

@property (nonatomic, weak) UIView *topView;

@property (nonatomic, strong) NSMutableArray *topButtonsArray;
@end

@implementation ZKRSearchChoiceController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    // topview高度
    self.tableView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
    
    [self loadTopData];
    
    [self setupTopView];
}

- (void)setupTopView
{
    UIView *topView = [[UIView alloc] init];
//    topView.backgroundColor = [UIColor blueColor];
    topView.frame = CGRectMake(0, -180, self.view.cgl_width, 180);
    [self.view addSubview:topView];
    self.topView = topView;
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, self.topView.cgl_width - 20, (self.topView.cgl_height - 30) * 0.5)];
    button1.backgroundColor = [UIColor redColor];
    button1.titleLabel.text = @"hehe";
    [self.topView addSubview:button1];
    [self.topButtonsArray addObject:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 10 + CGRectGetMaxY(button1.frame), (self.topView.cgl_width - 30) * 0.5, (self.topView.cgl_height - 30) * 0.5)];
    button2.backgroundColor = [UIColor orangeColor];
    [self.topView addSubview:button2];
    [self.topButtonsArray addObject:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(10 + CGRectGetMaxX(button2.frame), button2.cgl_y, button2.cgl_width, button2.cgl_height)];
    button3.backgroundColor = [UIColor blueColor];
    [self.topView addSubview:button3];
    [self.topButtonsArray addObject:button3];
}

- (void)loadTopData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"_appid"] = @"iphone";
    
    [manager GET:@"http://iphone.myzaker.com/zaker/find_promotion.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *array = [ZKRSearchChoiceTopItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"][0]];
        [array addObjectsFromArray:[ZKRSearchChoiceTopItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"][1]]];
        
        self.itemsArray = array;
        
        for (int i = 0; i < self.itemsArray.count; ++i) {
            ZKRSearchChoiceTopItem *item = self.itemsArray[i];
            UIButton *button = self.topButtonsArray[i];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:item.promotion_img] forState:UIControlStateNormal];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
