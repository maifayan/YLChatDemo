//
//  YLChatCell.h
//  YLChatDemo
//
//  Created by Apple on 2017/9/16.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLChatFrame;
@interface YLChatCell : UITableViewCell

@property (nonatomic ,strong) YLChatFrame *chatFrame;

+ (instancetype)YLCellWithTableView:(UITableView *)tableView;

@end
