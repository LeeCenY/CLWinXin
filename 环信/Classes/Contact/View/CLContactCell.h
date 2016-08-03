//
//  CLContactCell.h
//  CLWinXin
//
//  Created by nil on 16/8/3.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLContactCell : UITableViewCell


/** 好友模型（注意，由于是环信的账号，所以此处在开发中不建议传EMBuddy模型） */
@property (nonatomic, strong) EMBuddy *buddy;
+ (instancetype)cl_cellWithTableView:(UITableView *)tableView;

@end
