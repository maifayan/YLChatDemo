//
//  YLMessageViewController.m
//  YLChatDemo
//
//  Created by Apple on 2017/9/14.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import "YLMessageViewController.h"
#import "YLMessageInputBar.h"
#import "PureLayout.h"

#define YLInputViewH 46
@interface YLMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) YLMessageInputBar *inputBar;

@end

@implementation YLMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控件
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeBottom];
   
    [self.view addSubview:self.inputBar];
    [self.inputBar autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeTop];
    [self.inputBar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView];
    
    // 监听键盘弹出,对相应的布局做修改
    [self xmg_observerKeyboardFrameChange];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
    

    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
    
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

#pragma mark - 私有方法
- (void)xmg_observerKeyboardFrameChange
{
    [[NSNotificationCenter defaultCenter] addObserverForName: UIKeyboardWillChangeFrameNotification
                                                      object:nil
                                                       queue: [NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      //
                                                      //                                                      NSLog(@"%s, line = %d,note =%@", __FUNCTION__, __LINE__, note);
                                                      /**
                                                       note.userInfo
                                                       UIKeyboardAnimationCurveUserInfoKey = 7;
                                                       UIKeyboardAnimationDurationUserInfoKey = "0.25";
                                                       UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
                                                       UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
                                                       UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
                                                       UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
                                                       UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
                                                       UIKeyboardIsLocalUserInfoKey = 1;
                                                       self.view 可以根据 end.oriY来进行 布局改变
                                                       */
                                                      CGFloat endY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
                                                      CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
                                                      
                                                      CGFloat tempY = endY - self.view.bounds.size.height;
                                                      CGRect tempF = CGRectMake(0, tempY, self.view.bounds.size.width, self.view.bounds.size.height);
                                                      self.view.frame = tempF;
                                                      [UIView animateWithDuration:duration animations:^{
                                                          [self.view setNeedsLayout];
                                                      }];
                                                      
                                                      
                                                  }];
}


#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - YLInputViewH) style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;

    }
    return _tableView;
}

- (YLMessageInputBar *)inputBar{
    if (!_inputBar) {
        _inputBar       =  [[YLMessageInputBar alloc]init];
        _inputBar.frame =  CGRectMake(0, self.view.bounds.size.height - YLInputViewH, self.view.bounds.size.width, YLInputViewH);
        
    }
    return _inputBar;
}

@end
