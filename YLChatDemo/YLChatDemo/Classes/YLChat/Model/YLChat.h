//
//  YLChat.h
//  YLChatDemo
//
//  Created by Apple on 2017/9/16.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLChat : NSObject

/** 聊天消息对象 */
@property (nonatomic, strong) NSMutableDictionary *mesag;

/** 文字聊天内容 */
@property (nonatomic, copy, readonly) NSString *contentText;
/** 文字聊天的背景图 */
@property (nonatomic, strong, readonly) UIImage *contectTextBackgroundIma;
@property (nonatomic, strong, readonly) UIImage *contectTextBackgroundHLIma;
/** 头像urlStr */
@property (nonatomic, copy, readonly) NSString *userIcon;

/** nickeStr */
@property (nonatomic, copy, readonly) NSString *nickeName;

/** timeStr */
@property (nonatomic, copy, readonly) NSString *timeStr;

/** 是我还是他 */
@property (nonatomic, assign, getter=isMe, readonly) BOOL me;


@end
