//
//  YLChatCell.m
//  YLChatDemo
//
//  Created by Apple on 2017/9/16.
//  Copyright © 2017年 YaLeTeCh. All rights reserved.
//

#import "YLChatCell.h"
#import "XMGLongPressBtn.h"
#import "YLChatFrame.h"
#import "YLChat.h"
#import "UIImage+YFResizing.h"

@interface YLChatCell ()

/** timeLab */
@property (nonatomic, weak) UILabel *timeLab;
/** nickName */
@property (nonatomic, weak) UILabel *nickName;

/** 头像 */
@property (nonatomic, weak) XMGLongPressBtn *userIconBtn;

/** 聊天内容 */
@property (nonatomic, weak) XMGLongPressBtn *contentBtn;

@end



@implementation YLChatCell
{
    UIImage *_headImage;
}

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
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;

}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //此处添加子控件
        UILabel *timeLab        = [[UILabel alloc]init];
        timeLab.backgroundColor = [UIColor grayColor];
        timeLab.textColor       = [UIColor whiteColor];
        timeLab.textAlignment   = NSTextAlignmentCenter;
        timeLab.font            = ChatTimeFont;
        timeLab.layer.cornerRadius = 3;
        [self.contentView addSubview:timeLab];
        self.timeLab = timeLab;
        
        UILabel *nickName = [[UILabel alloc]init];
        nickName.textColor = [UIColor blackColor];
        nickName.textAlignment = NSTextAlignmentCenter;
        nickName.font = ChatTimeFont;
        nickName.layer.cornerRadius = 3;
        [self.contentView addSubview:nickName];
        self.nickName = nickName;
        
        XMGLongPressBtn *userIconBtn = [[XMGLongPressBtn alloc] init];
        userIconBtn.longPressBlock = ^(XMGLongPressBtn *btn){
            // 长按时的业务逻辑处理
        };
        [userIconBtn addTarget:self action:@selector(showDetailUserInfo) forControlEvents: UIControlEventTouchUpInside];
        [self.contentView addSubview: userIconBtn];
        self.userIconBtn = userIconBtn;
        
        XMGLongPressBtn *contentTextBtn = [[XMGLongPressBtn alloc] init];
        contentTextBtn.longPressBlock = ^(XMGLongPressBtn *btn){
            // 长按时的业务逻辑处理
        };
        contentTextBtn.titleLabel.font = ChatContentFont;
        contentTextBtn.titleLabel.numberOfLines = 0;
        
        [contentTextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [contentTextBtn addTarget:self action:@selector(contentChatTouchUpInside) forControlEvents: UIControlEventTouchUpInside];
        [self.contentView addSubview: contentTextBtn];
        self.contentBtn = contentTextBtn;
        
    }
    return self;
}
// 给子控件赋值
- (void)setChatFrame:(YLChatFrame *)chatFrame{
    _chatFrame = chatFrame;
    YLChat *chat = chatFrame.chat;
    self.timeLab.text  = chat.timeStr;
    self.nickName.text = chat.nickeName;
    // 如果是真实开发,此处应该用SDWebImage根据URL取图片
    if (chat.isMe) {
        NSURL  *daUrl = [NSURL URLWithString:chat.userIcon];
        NSData *data = [NSData dataWithContentsOfURL: daUrl];
        _headImage = [UIImage imageWithData:data];
        
    }else{
        
        // NSString --> NSData
        NSData *data=[[NSData alloc] initWithBase64EncodedString:chat.userIcon options:NSDataBase64DecodingIgnoreUnknownCharacters];
        // NSData --> UIImage
        _headImage = [UIImage imageWithData:data];
    }
    
    [self.userIconBtn setImage:_headImage forState: UIControlStateNormal];
    [self.contentBtn setBackgroundImage: [UIImage yf_resizingWithIma:chat.contectTextBackgroundIma] forState: UIControlStateNormal];
    [self.contentBtn setBackgroundImage: [UIImage yf_resizingWithIma:chat.contectTextBackgroundHLIma] forState: UIControlStateHighlighted];
    [self.contentBtn setTitle: chat.contentText forState: UIControlStateNormal];
}

//对子控件布局
-(void)layoutSubviews{
    [super layoutSubviews];
    self.timeLab.frame  = self.chatFrame.timeFrame;
    self.nickName.frame = self.chatFrame.nickFrame;
    self.userIconBtn.frame = self.chatFrame.iconFrame;
    self.contentBtn.frame  = self.chatFrame.contentFrame;
}

#pragma mark - 私有方法
- (void)showDetailUserInfo
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
}

- (void)contentChatTouchUpInside
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
}



@end
