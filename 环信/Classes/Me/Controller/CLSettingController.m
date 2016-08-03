//
//  CLSettingController.m
//  CLWinXin
//
//  Created by nil on 16/7/31.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLSettingController.h"
#import "CLLogRegController.h"

@interface CLSettingController ()

@end

@implementation CLSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)logOff:(id)sender {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
            NSLog(@"退出成功");
            NSLog(@"%s line = %d",__func__,__LINE__);
            //1.记录退出的用户名(为了用户在重新登录的时候，不必再次输入用户名，optional)
            [[NSUserDefaults standardUserDefaults] setObject:[[EaseMob sharedInstance].chatManager loginInfo][@"username"] forKey:@"username"];
            //2.切换控制器
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [CLLogRegController cl_logReg];
            
        }
    } onQueue:nil];
}


@end
