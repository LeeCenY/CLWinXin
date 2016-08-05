//
//  CLChatFrame.h
//  CLWinXin
//
//  Created by nil on 16/8/5.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLChat;

#define kTimeFont [UIFont  systemFontOfSize:13.0]
#define kContentFont [UIFont  systemFontOfSize:14.0]
#define kContentEdgeTop 15
#define kContentEdgeleft 20
#define kContentEdgeBottom 25
#define kContentEdgeRight 20

@interface CLChatFrame : NSObject

/** <#注释#> */
@property (nonatomic, strong) CLChat *chat;
/*布局属性*/

/** timeLab */
@property (nonatomic, assign, readonly) CGRect timeFrame;
/** 头像Lab */
@property (nonatomic, assign, readonly) CGRect iconFrame;
/** 内容Lab */
@property (nonatomic, assign, readonly) CGRect contentFrame;
/** cell高度*/
@property (nonatomic, assign, readonly) CGFloat cellH;

@end
