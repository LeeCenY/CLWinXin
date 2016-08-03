//
//  CLTabBarController.m
//  CLWinXin
//
//  Created by nil on 16/7/31.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLTabBarController.h"
#import "CLContactController.h"
@interface CLTabBarController () <EMChatManagerDelegate>

@end

@implementation CLTabBarController


- (instancetype)init {

    self = [super init];
    if (self) {
        self = [MainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    }
    return self;
}

+ (instancetype)cl_TabBarController {
    //返回【self alloc】 init】
    return [MainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIColor *selColor = [UIColor colorWithRed:0/255.0
                                        green:190/255.0
                                         blue:12/255.0
                                        alpha:1];
    for (UINavigationController *nav in self.childViewControllers) {
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:selColor} forState:UIControlStateSelected];
    }
    
    self.tabBar.tintColor = selColor;
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

}


#pragma mark - 接收到好友请求
//接收到好友请求时的好友请求
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message;
{

    //1.显示 badgeValue 改变
    [self cl_changeBadgeValue];
    //2.弹框问是否接收，如果同意就跳转通讯录界面
    [self cl_askForBuddyAccpect:username message:message];
    
    //3.刷新通讯录界面(直接可以设置通讯录为 chatManager 的代理，然后做处理)，buddyList 跟新方法中进行
    
    
}

#pragma mark - 私有方法

//tabBarItem
-(void)cl_changeBadgeValue {

    //badgeValue plus
    CLContactController *contactVC = [CLContactController cl_contactController];
    NSString *badgeValue = contactVC.navigationController.tabBarItem.badgeValue;
    NSInteger badgeNum = badgeValue.integerValue;
    badgeNum = badgeNum + 1;
    contactVC.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",badgeNum];
    
}

- (void)cl_askForBuddyAccpect:(NSString *)userName message:(NSString *)message {

    UIAlertController *ac = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@要添加您为好友",userName] message:[NSString stringWithFormat:@"理由:%@",message] preferredStyle:UIAlertControllerStyleActionSheet];
    [ac addAction:[UIAlertAction actionWithTitle:@"拒绝" style: UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //拒绝会发生的事情
        //告诉环信，拒绝了好友请求
        EMError *error = nil;
        BOOL isSuccess = [[EaseMob sharedInstance].chatManager rejectBuddyRequest:userName reason:@"不认识,不加你" error:&error];
        if (!error) {
            NSLog(@"拒绝成功");
        }
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"接收" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //接收好友
        EMError *error = nil;
        BOOL isSuccess = [[EaseMob sharedInstance].chatManager acceptBuddyRequest:userName error:&error];
        if (!error) {
            NSLog(@"接收成功");
            
            //跳转控制器到通讯录
//            self.tabBar.selectedItem = [CLContactController cl_contactController].navigationController.tabBarItem;
            
            self.selectedViewController = self.viewControllers[1];
            
            //刷新通讯录界面
            //更新通讯录好友列表
        }
    }]];
    [self presentViewController:ac animated:YES completion:nil];
}


@end
