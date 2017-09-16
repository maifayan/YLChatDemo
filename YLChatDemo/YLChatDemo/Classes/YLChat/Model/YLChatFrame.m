//
//  YLChatFrame.m
//  YLChatDemo
//
//  Created by Apple on 2017/9/16.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import "YLChatFrame.h"
#import "YLChat.h"

@interface YLChatFrame ()

/** timeLab */
@property (nonatomic, assign) CGRect timeFrame;

/** 头像frame */
@property (nonatomic, assign) CGRect iconFrame;

/** 昵称frame*/
@property (nonatomic, assign) CGRect nickFrame;


/** 内容的frame */
@property (nonatomic, assign) CGRect contentFrame;

/** cell高度 */
@property (nonatomic, assign) CGFloat cellH;


@end

@implementation YLChatFrame

- (void)setChat:(YLChat *)chat{
    _chat = chat;
    CGFloat screenW = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat margin  = 10;
    CGFloat timeX;
    CGFloat timeY   = 0;
    CGFloat timeW;
    CGFloat timeH   = 20;
    
    CGSize timeStrSize = [chat.timeStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName: ChatTimeFont}
                                                    context:nil].size;
    timeW = timeStrSize.width + 5;
    timeX = (screenW - timeW) *0.5;
    self.timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat iconX;
    CGFloat iconY = margin + CGRectGetMaxY(self.timeFrame);
    CGFloat iconW = 44;
    CGFloat iconH = iconW;
    
    CGFloat nickNameX;
    CGFloat nickNameY = iconY + iconH;
    CGFloat nickNameW = 80;
    CGFloat nickNameH = 30;
    
    CGFloat contentX;
    CGFloat contentY = iconY;
    CGFloat contentW;
    CGFloat contentH;
    
    CGFloat contentMaxW = screenW - 2 *(margin + iconW + margin);
    CGSize contentStrSize = [chat.contentText boundingRectWithSize:CGSizeMake(contentMaxW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ChatContentFont} context:nil].size;
    
    contentW = contentStrSize.width;
    contentH = contentStrSize.height;
    if (chat.isMe) {
        iconX  = screenW - margin - iconW;
        nickNameX = screenW - margin - iconW *0.5 - 5;
        contentX  = iconX - margin - contentW;
    }else{
        iconX = margin;
        nickNameX = margin + iconW *0.5 - 5;
        contentX  = iconX + iconW + margin;
    }
    self.iconFrame  = CGRectMake(iconX, iconY, iconW, iconH);
    self.nickFrame  = CGRectMake(nickNameX, nickNameY, nickNameW, nickNameH);
    self.contentFrame = CGRectMake(contentX, contentY, contentW, contentY);
    self.cellH      = (contentH > iconH)? CGRectGetMaxY(self.contentFrame) + margin + nickNameH:CGRectGetMaxY(self.iconFrame) + margin + nickNameH;
}



@end
