//
//  AppDelegate.m
//  环信
//
//  Created by nil on 16/7/30.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "AppDelegate.h"
#import "CLTabBarController.h"
#import "CLLogRegController.h"
#define AppKey @"930518#leeim"



@interface AppDelegate () <EMChatManagerDelegate>

@end

@implementation AppDelegate


//这个方法一般进行 各种 SDK appKey 的注册
//启动时，app 的跟控制器的判断切换
//对启动图留存时间的处理
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1 注册
    [[EaseMob sharedInstance] registerSDKWithAppKey:AppKey
                                       apnsCertName:nil
                                        otherConfig:@{kSDKConfigEnableConsoleLogger: @NO}];
    
    //2app 生命周期
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    //3.添加监听代理
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    //4判断是否自动登录状态
    if ([[EaseMob sharedInstance].chatManager isAutoLoginEnabled]) {
        
        //1.展示正在自动登录
        [SVProgressHUD showWithStatus:@"正在自动登录中..."];
        
        //2.在 didAutoLoginWithInfo
        
        
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[EaseMob sharedInstance] applicationWillTerminate:application];
    
    //移除代理
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}


//自动重连
- (void)willAutoReconnect {
    NSLog(@"%s, line = %d",__func__, __LINE__);
}
//自动重连成功
- (void)didAutoReconnectFinishedWithError:(NSError *)error {
    
    if (!error) {
        NSLog(@"%s, line = %d",__func__,__LINE__);
    }
}

//监听被动退出
- (void)didRemovedFromServer {

    [self cl_LogOffBeidong];
}
-(void)didLoginFromOtherDevice {
    [self cl_LogOffBeidong];
}

#pragma mark - 自动登录
-(void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error {

    [SVProgressHUD dismiss];
    if (error) {
        //显示错误，不切换控制器
        [JDStatusBarNotification showWithStatus:error.description dismissAfter:2.0];
    }else {
    
    //切换控制器
        
        //切换
        CLTabBarController *tabVC = [[CLTabBarController alloc] init];
        self.window.rootViewController =tabVC;
    }
}


//被动 logoff
- (void)cl_LogOffBeidong {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
            //被动回调
        if (!error) {
            //切换控制器
            self.window.rootViewController = [CLLogRegController cl_logReg];
        }
    } onQueue:nil];
}

@end
