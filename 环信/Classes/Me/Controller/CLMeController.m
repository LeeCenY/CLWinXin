//
//  CLMeController.m
//  CLWinXin
//
//  Created by nil on 16/7/31.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLMeController.h"

@interface CLMeController ()

//静态 cell 中如果有自定义 cell 的类，是不可以直接拖线，从文件中反向拖入 xib/storybary 中
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end

@implementation CLMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.userName.text = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
}

@end
