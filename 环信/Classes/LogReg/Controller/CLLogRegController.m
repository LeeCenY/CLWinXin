//
//  ViewController.m
//  环信
//
//  Created by nil on 16/7/30.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLLogRegController.h"
#import "EaseMob.h"
#import "CLTabBarController.h"

@interface CLLogRegController () <EMChatManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;


@end

@implementation CLLogRegController

+ (instancetype)cl_logReg {
    return [MainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *lasUser = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"username"];
    if (lasUser) {
        self.userName.text = lasUser;
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

}

- (IBAction)testReg:(id)sender {
    
    [SVProgressHUD showWithStatus:@"正在注册中..."];
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.userName.text
                                                         password:self.pwd.text
                                                   withCompletion:^(NSString *username, NSString *password, EMError *error) {
                                                       [SVProgressHUD dismiss];
                                                             if (!error) {
                                                            
                                                                 [JDStatusBarNotification showWithStatus:@"注册成功，请点击登录"
                                                                                            dismissAfter:2.5
                                                                                               styleName:JDStatusBarStyleWarning];
                                                                 
                                                                 [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                                                                 
                                                                                                                           }
                                                             NSLog(@"%s, line = %d",__func__, __LINE__);
                                                         } onQueue:nil];

}


//登录
- (IBAction)login:(id)sender {

    [SVProgressHUD showWithStatus:@"正在登录..."];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername: self.userName.text
                                                        password:self.pwd.text completion:^(NSDictionary *loginInfo, EMError *error) {
                                                            
                                                            [SVProgressHUD dismiss];
                                                            if (!error && loginInfo) {
                                                                
                                                                
                                                                [JDStatusBarNotification showWithStatus:@"登录成功" dismissAfter:1.5 styleName:JDStatusBarStyleSuccess];
                                                               
                                                                //1.在自动登录成功后设置自动登录
                                                                [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                                                                
                                                                //2.切换控制器为 TabVC
                                                                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                                                                window.rootViewController = [[CLTabBarController alloc]init];
                                                                

                                                                
                                                            }
                                                        } onQueue:nil];
}

//监听自动登录回调
-(void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error {

    NSLog(@"%s, line = %d",__func__, __LINE__);
}
//监听自动登录回调
-(void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error {

    NSLog(@"%s, line = %d",__func__, __LINE__);
}

//退出
- (IBAction)logOff:(id)sender {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
            NSLog(@"退出成功");
        }
    } onQueue:nil];
}



@end
