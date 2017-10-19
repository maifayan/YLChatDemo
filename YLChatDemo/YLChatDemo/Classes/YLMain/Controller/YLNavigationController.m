//
//  YLNavigationController.m
//  YLChatDemo
//
//  Created by Apple on 2017/9/14.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import "YLNavigationController.h"
#import "UINavigationBar+Awesome.h"
@interface YLNavigationController ()

@end

@implementation YLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationBar lt_setBackgroundColor: [UIColor blackColor]];
    [self.navigationBar setBackgroundColor:[UIColor blackColor]];
    // 修改标题颜色
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    // 修改左右UIBarButtonItem主题色
    self.navigationBar.tintColor = [UIColor whiteColor];
    
}

// 修改状态栏格式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
