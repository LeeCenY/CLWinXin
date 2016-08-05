//
//  CLGDtailUserInfoController.m
//  CLWinXin
//
//  Created by nil on 16/8/3.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLGDtailUserInfoController.h"
#import "UIImage+YFResizing.h"
#import "CLWeChatController.h"
#import "CLTabBarController.h"
#import "CLChatController.h"

@interface CLGDtailUserInfoController ()
@property (weak, nonatomic) IBOutlet UILabel *username;

@end

@implementation CLGDtailUserInfoController

+ (instancetype)cl_detailUserInfoVC {

    return [[UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"详细资料";
    //发消息的按钮
    [self cl_addBtns];
    //设置给谁发消息
    self.username.text = self.buddy.username;
}




#pragma mark - 添加发送消息按钮
- (void)cl_addBtns {

    CGFloat viewW = self.view.bounds.size.width;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, 200)];
    self.tableView.tableFooterView = footerView;
    UIButton *sendMsgBtn = [[UIButton alloc] init];
    [sendMsgBtn addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    
    [sendMsgBtn setBackgroundImage:[UIImage yf_imageWithColor:[UIColor colorWithRed:0/255.0 green:190/255.0 blue:12/255.0 alpha:1]] forState:UIControlStateNormal];
    [sendMsgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendMsgBtn setTitle:@"发消息" forState: UIControlStateNormal];
    sendMsgBtn.frame = CGRectMake(30, 0, viewW - 60, 44);

    sendMsgBtn.layer.cornerRadius = 5;
    sendMsgBtn.layer.masksToBounds = YES;
    
    [footerView addSubview:sendMsgBtn];
}


- (void)sendMsg {

    //先回到通讯录
     [self.navigationController popViewControllerAnimated:NO];
    //1.tabbar 选中控制器改变成微信
    CLTabBarController *tabVC = (CLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabVC.selectedViewController = tabVC.viewControllers[0];
    
    CLChatController *chatVC = [[CLChatController alloc] init];
    chatVC.buddy = self.buddy;

    //2.从 wechat 界面 push 过去
    [(UINavigationController *)tabVC.viewControllers[0] pushViewController:chatVC animated:YES];
    
   
    
}

@end
