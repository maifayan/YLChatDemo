//
//  YLFriendsCell.h
//  YLChatDemo
//
//  Created by Apple on 2017/9/14.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLFriendModel;
@interface YLFriendsCell : UITableViewCell

@property (nonatomic ,strong) YLFriendModel *friendMoel;

@property (nonatomic,strong) NSString *userId;

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

+ (instancetype)YLCellWithTableView:(UITableView *)tableView;

@end
