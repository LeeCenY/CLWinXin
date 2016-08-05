//
//  CLChatCell.m
//  CLWinXin
//
//  Created by nil on 16/8/5.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLChatCell.h"
#import "CLLongPressBtn.h"
#import "CLChatFrame.h"
#import "CLChat.h"
#import "UIImage+YFResizing.h"

@interface CLChatCell ()

/** timeLabel */
@property (nonatomic, weak) UILabel *timeLabel;
/** 头像 */
@property (nonatomic, weak) CLLongPressBtn *userIconBtn;
/** 聊天内容 */
@property (nonatomic, weak) CLLongPressBtn *contentBtn;

@end

@implementation CLChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = BackGroud243Color;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.backgroundColor = [UIColor grayColor];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = kTimeFont;
        timeLabel.layer.cornerRadius = 5;
        timeLabel.clipsToBounds = YES;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        CLLongPressBtn *userIconBtn = [[CLLongPressBtn alloc] init];
        userIconBtn.longPressBtnBlock = ^(CLLongPressBtn *btn) {
          //长按是的业务逻辑处理
            
        };
        [userIconBtn addTarget:self action:@selector(cl_showDetailUserInfo) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview: userIconBtn];
        self.userIconBtn = userIconBtn;
        
        CLLongPressBtn *contentTextBtn = [[CLLongPressBtn alloc] init];
        contentTextBtn.longPressBtnBlock = ^(CLLongPressBtn *btn) {
            //长按是的业务逻辑处理
        };
        
        contentTextBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentEdgeTop, kContentEdgeleft, kContentEdgeBottom, kContentEdgeRight);
        
        contentTextBtn.titleLabel.font = kContentFont;
        contentTextBtn.titleLabel.numberOfLines = 0;
        [contentTextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [contentTextBtn addTarget:self action:@selector(cl_contentChatTouch) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:contentTextBtn];
        self.contentBtn = contentTextBtn;
    }
    return self;
}

-(void)setChatFrame:(CLChatFrame *)chatFrame {

    _chatFrame = chatFrame;
    CLChat *chat = chatFrame.chat;
    self.timeLabel.text = chat.timeStr;
    
    [self.userIconBtn setImage:[UIImage imageNamed:chat.userIcon] forState:UIControlStateNormal];
    [self.contentBtn setTitle:chat.contentText forState:UIControlStateNormal];
    [self.contentBtn setBackgroundImage:[UIImage yf_resizingWithIma:chat.contentTextBackgroundIma] forState:UIControlStateNormal];
    [self.contentBtn setBackgroundImage:[UIImage yf_resizingWithIma:chat.contentTextBackgroundHLIma] forState:UIControlStateHighlighted];
}

//子控件布局
- (void)layoutSubviews {

    [super layoutSubviews];
    self.timeLabel.frame = self.chatFrame.timeFrame;
    self.userIconBtn.frame = self.chatFrame.iconFrame;
    self.contentBtn.frame = self.chatFrame.contentFrame;
}


#pragma mark - 私有方法
- (void)cl_showDetailUserInfo {

}

- (void)cl_contentChatTouch {

}
@end
