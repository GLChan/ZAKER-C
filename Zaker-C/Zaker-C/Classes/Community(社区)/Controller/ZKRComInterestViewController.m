//
//  ZKRComInterestViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/26.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRComInterestViewController.h"
#import "ZKRLoginViewController.h"

/**
 *  社区->关注
 */
@interface ZKRComInterestViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ZKRComInterestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.avatarImageView.image imageWithTintColor:[UIColor lightGrayColor]];
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.cgl_width * 0.5;
    self.avatarImageView.layer.masksToBounds = YES;
    
    [self.loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginButtonClick
{
    ZKRLoginViewController *loginVC = [[ZKRLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end
