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
#import "YLChatCell.h"
#import "YLChatFrame.h"


#define YLInputViewH 46
@interface YLMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

//显示聊天内容
@property (nonatomic ,strong) UITableView *tableView;
//输入框
@property (nonatomic ,strong) YLMessageInputBar *inputBar;

//聊天记录
@property (nonatomic,copy) NSMutableArray *dataArray;

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
    
    //点击空白区域取消
//    [self setupTapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //解决第一次进入Vc的时候,未滚动到最底部
    [self  tableViewScrollToBottom];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
    
}
#pragma mark - 点击空白区域键盘收回
- (void)setupTapGestureRecognizer{
    /**
     点击 空白区域取消
     */
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
}
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YLChatCell *cell = [YLChatCell YLCellWithTableView:tableView];
    cell.chatFrame     =  self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataArray[indexPath.row] cellH];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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

//tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
    if (self.dataArray.count==0)
        return;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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
