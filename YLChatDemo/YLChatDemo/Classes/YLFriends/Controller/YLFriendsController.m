//
//  YLFriendsController.m
//  YLChatDemo
//
//  Created by Apple on 2017/9/14.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import "YLFriendsController.h"
#import "YLFriendModel.h"
#import "YLFriendsCell.h"
#import "YLMessageViewController.h"

@interface YLFriendsController ()
//model
@property (nonatomic ,strong) YLFriendModel  *friendModel;
//数据源
@property (nonatomic ,strong) NSMutableArray *friendArray;

@end

@implementation YLFriendsController

+ (instancetype)YLFriendsController{
    return [MainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息";
    
    //获取数据
    [self getFriendsData];
    
}

#pragma mark - Data
- (void)getFriendsData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@user/list",YLUrl];
    [mgr POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *dataArray = [NSMutableArray array];
        dataArray = responseObject[@"data"];
        NSMutableDictionary *responDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < dataArray.count; i++) {
            [responDic setDictionary:dataArray[i]];
            if (![responDic[@"id"] isEqualToString:[[NSUserDefaults standardUserDefaults]valueForKey:@"fromID"]]) {
                _friendModel = [[YLFriendModel alloc]init];
                _friendModel.headimg  = responDic[@"headimg"];
                _friendModel.nickname = responDic[@"nickname"];
                _friendModel.userId   = responDic[@"id"];
                [self.friendArray addObject:_friendModel];
            }
        }
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.friendArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLFriendsCell *cell = [YLFriendsCell YLCellWithTableView:tableView];
    cell.friendMoel     =  self.friendArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YLFriendsCell *cell = [tableView cellForRowAtIndexPath:indexPath];// 获取cell 对象
    //对方
    [[NSUserDefaults standardUserDefaults] setObject:cell.userId forKey:@"toID"];
    NSData *data = UIImageJPEGRepresentation(cell.headView.image, 1.0f);
    [[NSUserDefaults standardUserDefaults] setObject:data  forKey:@"toHeadimg"];
    [[NSUserDefaults standardUserDefaults]setObject:cell.nickName.text forKey:@"toNickname"];
    
    YLMessageViewController *messageVC = [[YLMessageViewController alloc]init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

#pragma mark - 懒加载

- (NSMutableArray *)friendArray
{
    if (!_friendArray) {
        _friendArray = [NSMutableArray array];
    }
    return _friendArray;
}


@end
