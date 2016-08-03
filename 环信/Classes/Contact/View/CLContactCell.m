//
//  CLContactCell.m
//  CLWinXin
//
//  Created by nil on 16/8/3.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLContactCell.h"

@interface CLContactCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@end

@implementation CLContactCell

+ (instancetype)cl_cellWithTableView:(UITableView *)tableView {

    static NSString *ID = nil;
    if (!ID) {
        ID = [NSString stringWithFormat:@"%@ID", NSStringFromClass(self)];
    }
    static UITableView *tableV = nil;
    if (![tableView isEqual:tableV]) {
        //如果使用的是不同的 tableView，那就更新缓存池对应的 tableV
        tableV = tableView;
    }
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}


- (void)setBuddy:(EMBuddy *)buddy {


    _buddy = buddy;
    self.userName.text = buddy.username;
    self.userIcon.image = [UIImage imageNamed:@"add_friend_icon_addgroup"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
