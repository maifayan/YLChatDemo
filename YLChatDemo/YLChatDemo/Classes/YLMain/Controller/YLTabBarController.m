//
//  YLTabBarController.m
//  YLChatDemo
//
//  Created by Apple on 2017/9/14.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import "YLTabBarController.h"

@interface YLTabBarController ()

@end

@implementation YLTabBarController

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [MainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([YLTabBarController class])];
    }
    return self;
}

+ (instancetype)YLTabBarController{
    return [MainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *selColor = [UIColor colorWithRed: 0
                                        green: 190 / 255.0
                                         blue: 12 / 255.0
                                        alpha: 1];
    for (UINavigationController *nav in self.childViewControllers) {
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: selColor}
                                      forState: UIControlStateSelected];
    }
    
    self.tabBar.tintColor = selColor;
    
}

@end
