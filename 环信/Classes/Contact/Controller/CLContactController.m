//
//  CLContactController.m
//  CLWinXin
//
//  Created by nil on 16/8/3.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLContactController.h"
#import "CLContactCell.h"
#import "CLGDtailUserInfoController.h"
#import "CLTabBarController.h"
#import "CLWeChatController.h"

@interface CLContactController ()<EMChatManagerDelegate>

/** <#注释#> */
@property (nonatomic,copy) NSMutableArray *friends;

@end

@implementation CLContactController


+ (instancetype)cl_contactController {

    return [MainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

- (NSMutableArray *)friends {

    if (!_friends) {
        _friends = [NSMutableArray array];
        
        //好友列表
        NSArray *buddies = [[EaseMob sharedInstance].chatManager buddyList];
        if (buddies.count) {
            [_friends addObjectsFromArray:buddies];
        }
    }
    return _friends;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通讯录";
    //设置添加好友按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contacts_add_friend"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(addfriend)];
//    //注册 cell
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //监听好友列表的刷新
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

#pragma mark - 添加好友
- (void)addfriend {

    //微信中，它是直接 push 到一个搜索界面，然后再做响应的处理
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"好友申请" message:nil preferredStyle: UIAlertControllerStyleAlert];
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"填写用户名";
    }];
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"填写理由";
    }];
    [ac addAction:[UIAlertAction actionWithTitle:@"发送" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //发送好友请求
        EMError *error = nil;
        [[EaseMob sharedInstance].chatManager addBuddy:ac.textFields.firstObject.text message:ac.textFields.lastObject.text error:&error];
        if (!error) {
            NSLog(@"发送好友请求");
        }
    }]];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:ac animated:YES completion:^{
        
    }];

}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CLContactCell *cell = [CLContactCell cl_cellWithTableView:tableView];
    EMBuddy *buddy = self.friends[indexPath.row];
    cell.buddy = buddy;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    EMBuddy *buddy = self.friends[indexPath.row];
    CLGDtailUserInfoController *duivc =[CLGDtailUserInfoController cl_detailUserInfoVC];
    duivc.buddy = buddy;
    [self.navigationController pushViewController:duivc animated:YES];
    
}

//左滑删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除当前好友
        EMBuddy *buddy = self.friends[indexPath.row];
        EMError *error =nil;
        [[EaseMob sharedInstance].chatManager removeBuddy:buddy.username removeFromRemote:YES error:&error];
        if (!error) {
            NSLog(@"删除成功");
        }
    }
}

#pragma mark - 监听好友列表的刷新
- (void)didUpdateBuddyList:(NSArray *)buddyList changedBuddies:(NSArray *)changedBuddies isAdd:(BOOL)isAdd {

    NSLog(@"%s , line = %d, buddylist = %@,changebuddier = %@,isAdd = %d", __func__,__LINE__,buddyList,changedBuddies,isAdd);
    
    [self.friends removeAllObjects]; //删除
    [self.friends addObjectsFromArray:buddyList]; //添加
    [self.tableView reloadData]; //刷新
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
