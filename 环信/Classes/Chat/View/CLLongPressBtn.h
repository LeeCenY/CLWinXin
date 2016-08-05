//
//  CLLongPressBtn.h
//  CLWinXin
//
//  Created by nil on 16/8/5.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLLongPressBtn;
typedef void(^CLLongPressBtnBlock)(CLLongPressBtn *btn);
@interface CLLongPressBtn : UIButton

/** 传点击对方头像 */
@property (nonatomic,copy) CLLongPressBtnBlock longPressBtnBlock;
@end
