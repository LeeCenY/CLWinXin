//
//  CLInputView.m
//  CLWinXin
//
//  Created by nil on 16/8/3.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLInputView.h"

@implementation CLInputView

+(instancetype)cl_inpntView{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

@end
