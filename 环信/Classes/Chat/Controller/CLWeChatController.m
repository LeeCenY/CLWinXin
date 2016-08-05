//
//  CLWeChatController.m
//  CLWinXin
//
//  Created by nil on 16/8/3.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLWeChatController.h"

NSString * const YFWeChatTitleNormal = @"微信";
NSString * const YFWeChatTitleWillConnect = @"连接中...";
NSString * const YFWeChatTitleDisConnect = @"微信(未连接)";
NSString * const YFWeChatTitleWillReceiveMsg = @"收取中...";

@interface CLWeChatController () <EMChatManagerDelegate>

@end

@implementation CLWeChatController

+(instancetype)cl_weChatController {

    return [MainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = YFWeChatTitleNormal;
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

#pragma mark -  链接状态的监听
//即将自动重连
- (void)willAutoReconnect {
    
    
}
//自动重连成功
- (void)didAutoReconnectFinishedWithError:(NSError *)error {
    
    if (!error) {
        //成功
        self.title = YFWeChatTitleNormal;
    }else{
        //失败
        self.title = YFWeChatTitleDisConnect;
    }

}
//链接状态改变
-(void)didConnectionStateChanged:(EMConnectionState)connectionState {
    
    switch (connectionState) {
        case eEMConnectionConnected:
        {
            //链接状态
             self.title = YFWeChatTitleNormal;
        }
            break;
        case eEMConnectionDisconnected:
        {
            //未链接状态
            self.title = YFWeChatTitleDisConnect;
        }
            break;
            
        default:
            break;
    }
}

@end
