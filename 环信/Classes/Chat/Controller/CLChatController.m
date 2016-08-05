//
//  CLChatController.m
//  CLWinXin
//
//  Created by nil on 16/8/3.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLChatController.h"
#import "CLInputView.h"
#import "CLChat.h"
#import "CLChatCell.h"
#import "CLChatFrame.h"

#define kInputViewH 44

@interface CLChatController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>

/** <#注释#> */
@property (nonatomic, strong) UITableView *tableView;
/** <#注释#> */
@property (nonatomic, strong) CLInputView *inputView;
/** <#注释#> */
@property (nonatomic, copy) NSMutableArray *chatMsgs;

@end

@implementation CLChatController


-(UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = BackGroud243Color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height );
    }
    return _tableView;
}

- (CLInputView *)inputView {

    if (!_inputView) {
        _inputView = [CLInputView cl_inpntView];
        _inputView.textField.delegate = self;
        _inputView.frame = CGRectMake(0, self.view.bounds.size.height - kInputViewH, self.view.bounds.size.width, kInputViewH);
    }
    return _inputView;
}

- (NSMutableArray *)chatMsgs {

    if (!_chatMsgs) {
        _chatMsgs = [NSMutableArray array];
    }
    return _chatMsgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview: self.tableView];
    [self.view addSubview: self.inputView];
    
    //显示标题
    self.title = self.buddy.username;
    
    //获取会话中的聊天记录
    [self cl_reloadChatMsgs];
    
    //监听键盘弹出
    [self cl_keyboardWillChangeFrameNotification];
    //注册 cell
    [self.tableView registerClass:[CLChatCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
    //解决第一次进入聊天自动滚动到最后
    [self cl_scrollToBottom];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.chatMsgs.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
     CLChatCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([self class])];
     cell.chatFrame = self.chatMsgs[indexPath.row];
    
     return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self.chatMsgs[indexPath.row] cellH];
}


#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.view endEditing:YES];
}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    //在此处发送消息
    
    //3.构造 EMChatText 对象
    EMChatText *chatText = [[EMChatText alloc] initWithText:textField.text];
    //2.构造body 对象,需要传 EMChatText
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:chatText];
    //1.构造消息，发现 body 对象
    EMMessage *emsg = [[EMMessage alloc] initWithReceiver:self.buddy.username bodies:@[body]];
    //0.异步方法, 发送一条消息
    //@discussion 待发送的消息对象和发送后的消息对象是同一个对象, 在发送过程中对象属性可能会被更改
    [[EaseMob sharedInstance].chatManager asyncSendMessage: emsg progress:nil prepare:^(EMMessage *message, EMError *error) {
        //即将发送时的回调
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        //发送结束时的回调
        
        //此处可以先添加 msg 到数据中，
        
        //刷新列表
        
        //等待发送成功后再新刷新
        
        //一般用于大图片/视频/音频
        
        
        if (!error) {
            NSLog(@"发送成功");
            textField.text = nil;
            //移除键盘
            [textField resignFirstResponder];
            
            //刷新界面
            [self cl_reloadChatMsgs];
        }
        
    } onQueue:nil];
    //刷新列表
    return YES;
}

#pragma mark - 私有方法
//键盘监控
- (void)cl_keyboardWillChangeFrameNotification {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"%s,line = %d, noto = %@",__func__,__LINE__,note);
        
        CGFloat endY = [note.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        CGFloat duration = [note.userInfo [UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGFloat tempY = endY - self.view.bounds.size.height;
        CGRect tempF =CGRectMake(0, tempY, self.view.bounds.size.width, self.view.bounds.size.height);
        self.view.frame = tempF;
        [UIView animateWithDuration:duration animations:^{
            [self.view setNeedsLayout];
        }];
    }];
}

- (void)cl_reloadChatMsgs {

    //首先刷新的时候要移除已有的对象
    [self.chatMsgs removeAllObjects];
    
    //拿到当前的会话对象，一个传 username，另一个传聊天样式
    /*
     @brief 会话类型
     @constant eConversationTypeChat            单聊会话
     @constant eConversationTypeGroupChat       群聊会话
     @constant eConversationTypeChatRoom        聊天室会话
     */
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.buddy.username conversationType:eConversationTypeChat];
    //获取会话中的聊天记录(从数据库中加载消息)
    NSArray *msgs = [conversation loadAllMessages];
    
    for (EMMessage *emsg in msgs) {
        
        //把 emsg 传过去 解析普通消息
        CLChat *chat = [[CLChat alloc] init];
        chat.emsg = emsg;
        
        //把 chat 传过去计算位置
        CLChatFrame *chatFrame = [[CLChatFrame alloc] init];
        chatFrame.chat = chat;
        
        [self.chatMsgs addObject:chatFrame];
    }
    
    
//    [self.chatMsgs addObjectsFromArray:msgs];
    
    //刷新表格
    [self.tableView reloadData];
    
    //滚动最下面
    [self cl_scrollToBottom];
}

- (void)cl_scrollToBottom {
    
    if (self.chatMsgs.count == 0) {
        return;
    }
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.chatMsgs.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


@end
