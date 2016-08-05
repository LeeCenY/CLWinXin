//
//  CLChat.h
//  CLWinXin
//
//  Created by nil on 16/8/5.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLChat : NSObject

/** 环信聊天对象 */
@property (nonatomic, strong) EMMessage *emsg;
/** 文字聊天内容 */
@property (nonatomic, copy, readonly) NSString *contentText;
/** 文字聊天背景图方向 */
@property (nonatomic, copy, readonly)  UIImage *contentTextBackgroundIma;
/** 文字聊天背景图方向高亮 */
@property (nonatomic, copy, readonly)  UIImage *contentTextBackgroundHLIma;
/** 头像 */
@property (nonatomic, copy, readonly) NSString *userIcon;
/** 时间 */
@property (nonatomic, copy, readonly) NSString *timeStr;
/** 是我还是他 */
@property (nonatomic, assign, getter=isMe, readonly) BOOL me;

@end
