//
//  YLMessageViewController.m
//  YLChatDemo
//
//  Created by Apple on 2017/9/14.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import "YLMessageViewController.h"

#define YLInputViewH 46
@interface YLMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;


@end

@implementation YLMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控件
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    YLFriendsCell *cell = [YLFriendsCell YLCellWithTableView:tableView];
//    cell.friendMoel     =  self.friendArray[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //    self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
}


#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - YLInputViewH) style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;

    }
    return _tableView;
}


@end
