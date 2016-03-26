//
//  ZKRFunLocationController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/3/4.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRFunLocationController.h"
#import "AFHTTPSessionManager.h"
#import "ZKRCityItem.h"
#import "MJExtension.h"

/**
 *  玩乐 - 分类 - 定位
 */

@interface ZKRFunLocationController ()


@property (nonatomic, strong) NSArray *cities;

@property (nonatomic, strong) NSArray *hotCities;

@end

@implementation ZKRFunLocationController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city_list" ofType:@"json"];
    
    [self loadCity];
}

- (void)loadCity
{
    //1 获得json文件的全路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_list.json" ofType:nil];
    
    //2 加载json文件到data中
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //3 解析json数据
    //json数据中的[] 对应OC中的NSArray
    //json数据中的{} 对应OC中的NSDictionary
    
    NSDictionary *jsonArray =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
    
    
    self.cities = [ZKRCityItem mj_objectArrayWithKeyValuesArray:jsonArray[@"data"][@"cities"]];
//    NSLog(@"%@", self.cities);

    self.hotCities = [ZKRCityItem mj_objectArrayWithKeyValuesArray:jsonArray[@"data"][@"hot_cities"]];

//    hot_cities
    
    
    
    
}

#pragma mark - ---| data source |---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    
    ZKRCityItem *item = self.cities[indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
