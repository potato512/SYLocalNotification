//
//  NotificationUtil.m
//  DemoNotification
//
//  Created by zhangshaoyu on 2020/4/15.
//  Copyright © 2020 devZhang. All rights reserved.
//

#import "NotificationUtil.h"
#import <UserNotifications/UserNotifications.h>

@implementation NotificationUtil


//+ (void)registerNotification
//{
//    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    [center setNotificationCategories:[NotificationUtil createNotificationCategoryActions]];
//    // 必须写代理，不然无法监听通知的接收与点击
//    center.delegate = self;
//    //判断当前注册状态
//    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//        if (settings.authorizationStatus==UNAuthorizationStatusNotDetermined) {
//            [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
//                if (granted) {
//                    [[UIApplication sharedApplication] registerForRemoteNotifications];
//                }
//            }];
//        }
//    }];
//}
//
//// 添加category:
//+ (NSSet *)createNotificationCategoryActions
//{
//    //注册本地通知用到的Action
//    //进入app按钮
//    UNNotificationAction * localAction = [UNNotificationAction actionWithIdentifier:@"localAction" title:@"处理本地通知" options:UNNotificationActionOptionForeground];
//    ///回复文本按钮
//    UNTextInputNotificationAction * localText = [UNTextInputNotificationAction actionWithIdentifier:@"localText" title:@"本地文本" options:UNNotificationActionOptionNone];
//    //取消按钮
//    UNNotificationAction *localCancel = [UNNotificationAction actionWithIdentifier:@"localCancel" title:@"取消" options:UNNotificationActionOptionDestructive];
//    //将这些action带入category
//    UNNotificationCategory *localCategory = [UNNotificationCategory categoryWithIdentifier:@"localCategory" actions:@[localAction,localText,localCancel] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
//    return [NSSet setWithObjects:remoteCategory,localCategory,nil];
//}




+ (void)addNotificationMessage:(NSString *)message
{
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
//    notificationContent.title = @"iOS10本地通知";
//    notificationContent.subtitle = @"扶我起来";
    notificationContent.body = message;
    notificationContent.badge = @1;
    notificationContent.userInfo = @{@"content" : @"我是userInfo"};
    //添加音效
    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"music.mp3"];
    notificationContent.sound = sound;
    // 添加附件
    NSString *imageFile = [[NSBundle mainBundle]pathForResource:@"image" ofType:@"jpg"];
    UNNotificationAttachment *image = [UNNotificationAttachment attachmentWithIdentifier:@"image" URL:[NSURL fileURLWithPath:imageFile] options:nil error:nil];
    notificationContent.attachments = @[image];
    
    //添加触发器
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
    NSString *identifer = @"identifer";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifer content:notificationContent trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter]addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"发送成功");
        }
    }];
}

+ (void)removeNotification
{
    
}

@end
