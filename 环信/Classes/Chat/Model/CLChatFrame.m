//
//  CLChatFrame.m
//  CLWinXin
//
//  Created by nil on 16/8/5.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLChatFrame.h"
#import "CLChat.h"

@interface CLChatFrame ()

/** timeLab */
@property (nonatomic, assign) CGRect timeFrame;
/** 头像Lab */
@property (nonatomic, assign) CGRect iconFrame;
/** 内容Lab */
@property (nonatomic, assign) CGRect contentFrame;
/** cell高度*/
@property (nonatomic, assign) CGFloat cellH;


@end

@implementation CLChatFrame

- (void)setChat:(CLChat *)chat {

    _chat = chat;
    
    CGFloat screenW = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGFloat margin = 10;
    CGFloat timeX;
    CGFloat timeY = 0;
    CGFloat timeW;
    CGFloat timeH = 20;
    
    CGSize timeStrSize = [chat.timeStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kTimeFont} context:nil].size;
    timeW = timeStrSize.width + 5;
    timeX = (screenW - timeW) * 0.5;
    self.timeFrame = CGRectMake(timeX, timeH, timeW, timeH);
    
    
    CGFloat iconX;
    CGFloat iconY = margin + CGRectGetMaxY(self.timeFrame);
    CGFloat iconW = 44;
    CGFloat iconH = iconW;
    
    CGFloat contextX;
    CGFloat contextY = iconY;
    CGFloat contextW;
    CGFloat contextH;
    
    CGFloat contentMaxW = screenW - 2 * (margin + iconW + margin);
    
    CGSize contentStrSize =[chat.contentText boundingRectWithSize:CGSizeMake(contentMaxW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kContentFont} context:nil].size;
    
    contextW = contentStrSize.width + kContentEdgeleft + kContentEdgeRight;
    contextH = contentStrSize.height + kContentEdgeTop + kContentEdgeBottom;
    if (chat.isMe) {
        
        iconX = screenW - margin - iconW;
        contextX = iconX - margin - contextW;
    
    }else {
        iconX = margin;
        contextX = iconX + iconW + margin;
    }
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    self.contentFrame = CGRectMake(contextX, contextY, contextW, contextH);
    
    self.cellH = (contextH > iconH) ? CGRectGetMaxY(self.contentFrame) + margin : CGRectGetMaxY(self.iconFrame) + margin;
}

@end
