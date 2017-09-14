//
//  YLFriendsCell.m
//  YLChatDemo
//
//  Created by Apple on 2017/9/14.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import "YLFriendsCell.h"
#import "YLFriendModel.h"

@implementation YLFriendsCell

+ (instancetype)YLCellWithTableView:(UITableView *)tableView{
    static NSString *ID = nil;
    if (!ID) {
        ID = [NSString stringWithFormat:@"%@ID",NSStringFromClass(self)];
    }
    static UITableView *tableV = nil;
    if (![tableView isEqual:tableV]) {
        // 如果使用的是不同的tableView,那就更新缓存池对应的tableV
        tableV = tableView;
    }
    id cell = [tableV dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }

    return cell;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setFriendMoel:(YLFriendModel *)friendMoel{
    _friendMoel = friendMoel;
    
    self.headView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:friendMoel.headimg]]];
    self.nickName.text  = friendMoel.nickname;
    self.userId         = friendMoel.userId;
}

@end
