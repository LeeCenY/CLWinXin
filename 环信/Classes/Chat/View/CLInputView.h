//
//  CLInputView.h
//  CLWinXin
//
//  Created by nil on 16/8/3.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLInputView : UIView
@property (weak, nonatomic) IBOutlet UITextField *textField;

+( instancetype)cl_inpntView;

@end
