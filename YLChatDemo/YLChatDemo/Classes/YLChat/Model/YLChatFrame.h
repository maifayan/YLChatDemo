//
//  YLChatFrame.h
//  YLChatDemo
//
//  Created by Apple on 2017/9/16.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//




#define ChatTimeFont [UIFont systemFontOfSize:11]   //时间字体
#define ChatContentFont [UIFont systemFontOfSize:14]//内容字体


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class YLChat;
@interface YLChatFrame : NSObject

@property (nonatomic ,strong) YLChat *chat;

/** timeLab */
@property (nonatomic, assign, readonly) CGRect timeFrame;

/** 头像frame */
@property (nonatomic, assign, readonly) CGRect iconFrame;

/** 昵称frame*/
@property (nonatomic, assign, readonly) CGRect nickFrame;

/** 内容的frame */
@property (nonatomic, assign, readonly) CGRect contentFrame;

/** cell高度 */
@property (nonatomic, assign, readonly) CGFloat cellH;

@end
