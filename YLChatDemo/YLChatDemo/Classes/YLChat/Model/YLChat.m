//
//  YLChat.m
//  YLChatDemo
//
//  Created by Apple on 2017/9/16.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import "YLChat.h"
#import "NSString+YFTimestamp.h"

@interface YLChat ()

/** 文字聊天内容 */
@property (nonatomic, copy) NSString *contentText;
/** 文字聊天的背景图 */
@property (nonatomic, strong) UIImage *contectTextBackgroundIma;
@property (nonatomic, strong) UIImage *contectTextBackgroundHLIma;

/** 头像urlStr */
@property (nonatomic, copy) NSString *userIcon;

/** nickeStr */
@property (nonatomic, copy) NSString *nickeName;

/** timeStr */
@property (nonatomic, copy) NSString *timeStr;

/** 是我还是他 */
@property (nonatomic, assign, getter=isMe) BOOL me;

@end

@implementation YLChat

- (void)setMesag:(NSMutableDictionary *)mesag{
    _mesag = mesag;
    NSString *loginUser = [[NSUserDefaults standardUserDefaults] valueForKey:@"fromID"];
    if ([loginUser isEqualToString:mesag[@"fromUser"]]) {
        self.me = YES;
        self.userIcon = [[NSUserDefaults standardUserDefaults] valueForKey:@"fromHeadimg"];
        self.nickeName = [[NSUserDefaults standardUserDefaults]valueForKey:@"fromNickname"];
        self.contectTextBackgroundIma = [UIImage imageNamed: @"SenderTextNodeBkg"];
        self.contectTextBackgroundHLIma = [UIImage imageNamed: @"SenderTextNodeBkgHL"];
    }else
    {
        self.me = NO;
        NSData *headData = [[NSUserDefaults standardUserDefaults]valueForKey:@"toHeadimg"];
        NSString *imageDataString = [headData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        self.userIcon = imageDataString;
        self.nickeName = [[NSUserDefaults standardUserDefaults]valueForKey:@"toNickname"];
        self.contectTextBackgroundIma = [UIImage imageNamed: @"ReceiverTextNodeBkg"];
        self.contectTextBackgroundHLIma = [UIImage imageNamed: @"ReceiverTextNodeBkgHL"];
    }
    
    self.timeStr = [NSString yf_convastionTimeStr:[mesag[@"timeStamp"] longLongValue]];
    
    // 解析消息内容
    self.contentText = mesag[@"content"];
    
}


@end
