//
//  CLChat.m
//  CLWinXin
//
//  Created by nil on 16/8/5.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLChat.h"
#import "NSString+YFTimestamp.h"

@interface CLChat ()

/** 文字聊天内容 */
@property (nonatomic, copy) NSString *contentText;
/** 文字聊天背景图方向 */
@property (nonatomic,copy)  UIImage *contentTextBackgroundIma;
/** 文字聊天背景图方向高亮 */
@property (nonatomic,copy)  UIImage *contentTextBackgroundHLIma;
/** 头像 */
@property (nonatomic, copy) NSString *userIcon;
/** 时间 */
@property (nonatomic, copy) NSString *timeStr;
/** 是我还是他 */
@property (nonatomic, assign, getter=isMe) BOOL me;

@end

@implementation CLChat

-(void)setEmsg:(EMMessage *)emsg {

    _emsg = emsg;
    
    NSString *loginUser = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    if ([loginUser isEqualToString:emsg.from]) {
        self.me = YES;
        self.userIcon = @"add_friend_icon_addgroup";
        self.contentTextBackgroundIma = [UIImage imageNamed: @"SenderTextNodeBkg"];
        self.contentTextBackgroundHLIma = [UIImage imageNamed: @"SenderTextNodeBkgHL"];
    }else {
        self.me = NO;
        self.userIcon = @"add_friend_icon_offical";
        self.contentTextBackgroundIma = [UIImage imageNamed: @"ReceiverTextNodeBkg"];
        self.contentTextBackgroundHLIma = [UIImage imageNamed: @"ReceiverTextNodeBkgHL"];
    }
    self.timeStr = [NSString yf_convastionTimeStr:emsg.timestamp];

    //解析普通消息
    id<IEMMessageBody> msgBody = emsg.messageBodies.firstObject;
    switch (msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            NSLog(@"收到的文字是 txt -- %@",txt);
            
            self.contentText = txt;
            
        }
            break;
        case eMessageBodyType_Image:
        {
            // 得到一个图片消息body
            EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
            NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
            NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用SDK提供的下载方法后才会存在
            NSLog(@"大图的secret -- %@"    ,body.secretKey);
            NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
            NSLog(@"大图的下载状态 -- %lu",body.attachmentDownloadStatus);
            
            
            // 缩略图sdk会自动下载
            NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
            NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
            NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
            NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
            NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
        }
            break;
        case eMessageBodyType_Location:
        {
            EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
            NSLog(@"纬度-- %f",body.latitude);
            NSLog(@"经度-- %f",body.longitude);
            NSLog(@"地址-- %@",body.address);
        }
            break;
        case eMessageBodyType_Voice:
        {
            // 音频SDK会自动下载
            EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用SDK提供的下载方法后才会存在（音频会自动调用）
            NSLog(@"音频的secret -- %@"        ,body.secretKey);
            NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"音频文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
            NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
        }
            break;
        case eMessageBodyType_Video:
        {
            EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
            
            NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用SDK提供的下载方法后才会存在
            NSLog(@"视频的secret -- %@"        ,body.secretKey);
            NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"视频文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
            NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
            NSLog(@"视频的W -- %f ,视频的H -- %f", body.size.width, body.size.height);
            
            // 缩略图sdk会自动下载
            NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
            NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailRemotePath);
            NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
            NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
        }
            break;
        case eMessageBodyType_File:
        {
            EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
            NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
            NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用SDK提供的下载方法后才会存在
            NSLog(@"文件的secret -- %@"        ,body.secretKey);
            NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"文件文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
        }
            break;
            
        default:
            break;
    }
    
    
    
}

@end
