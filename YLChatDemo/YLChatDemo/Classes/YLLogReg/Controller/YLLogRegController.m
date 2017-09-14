//
//  YLLogRegController.m
//  YLChatDemo
//
//  Created by Apple on 2017/9/14.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import "YLLogRegController.h"
#import "YLTabBarController.h"

@interface YLLogRegController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;


@end

@implementation YLLogRegController

+ (instancetype)YLLogRegVc{
    return [MainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}





//注册
- (IBAction)registered:(UIButton *)sender {
    
    [SVProgressHUD showWithStatus: @"注册中..."];
    //这里的图片后期要换成用户自己提供的
    NSString *str = @"https://wx.qlogo.cn/mmopen/noZWlkaPOrC29mU7vUWFrvxuHzaWibF1Cfia5WicNOafQC4B2zQvabnd93jULHJkDV6RvVcO3gGic7OPzwvu0EEfNw8UEgq24SvZ/0";
    NSURL *URL = [NSURL URLWithString:str];  //string>url
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary  *dic = [NSMutableDictionary dictionary];
    dic[@"username"] = self.userName.text;
    dic[@"password"] = self.password.text;
    dic[@"nickname"] = @"随心所欲";
    dic[@"headimg"]  = URL;
    NSString *urlStr = [NSString stringWithFormat:@"%@user/reg",YLUrl];
    
    [mgr POST:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
        NSLog(@"%@",responseObject);
        [JDStatusBarNotification showWithStatus:@"注册成功,请点击登录"
                                   dismissAfter:2.0
                                      styleName: JDStatusBarStyleWarning];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
        NSLog(@"%@",error);
        [JDStatusBarNotification showWithStatus:@"注册失败"
                                   dismissAfter:2.0
                                      styleName: JDStatusBarStyleWarning];
    }];
    
}
//登录
- (IBAction)login:(UIButton *)sender {
    [SVProgressHUD showWithStatus: @"正在登录中..."];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary  *dic = [NSMutableDictionary dictionary];
    dic[@"username"] = self.userName.text;
    dic[@"password"] = self.password.text;
    NSString *urlStr = [NSString stringWithFormat:@"%@user/login",YLUrl];
    [mgr POST:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
        //        NSLog(@"登录====>%@",responseObject);
        [JDStatusBarNotification showWithStatus:@"登录成功"
                                       dismissAfter:2.0
                                          styleName: JDStatusBarStyleSuccess];
        //我
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"id"]  forKey:@"fromID"];
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"headimg"] forKey:@"fromHeadimg"];
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"nickname"] forKey:@"fromNickname"];
            
     //切换根控制器为: tabVc
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        window.rootViewController = [YLTabBarController YLTabBarController];
        
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
        NSLog(@"%@",error);
        [JDStatusBarNotification showWithStatus:@"登录失败"
                                   dismissAfter:2.0
                                      styleName: JDStatusBarStyleWarning];
    }];
    
    
}

@end
