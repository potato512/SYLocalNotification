//
//  AppDelegate.m
//  DemoNotification
//
//  Created by zhangshaoyu on 2020/4/15.
//  Copyright © 2020 devZhang. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center setNotificationCategories:[self createNotificationCategoryActions]];
    // 必须写代理，不然无法监听通知的接收与点击
    center.delegate = self;
    //判断当前注册状态
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus==UNAuthorizationStatusNotDetermined) {
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                }
            }];
        }
    }];
    
    return YES;
}

//添加category:
-(NSSet *)createNotificationCategoryActions{
    //注册本地通知用到的Action
    //进入app按钮
    UNNotificationAction * localAction = [UNNotificationAction actionWithIdentifier:@"localAction" title:@"处理本地通知" options:UNNotificationActionOptionForeground];
    ///回复文本按钮
    UNTextInputNotificationAction * localText = [UNTextInputNotificationAction actionWithIdentifier:@"localText" title:@"本地文本" options:UNNotificationActionOptionNone];
    //取消按钮
    UNNotificationAction *localCancel = [UNNotificationAction actionWithIdentifier:@"localCancel" title:@"取消" options:UNNotificationActionOptionDestructive];
    //将这些action带入category
    UNNotificationCategory *localCategory = [UNNotificationCategory categoryWithIdentifier:@"localCategory" actions:@[localAction,localText,localCancel] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
//    return [NSSet setWithObjects:remoteCategory,localCategory,nil];
    return [NSSet setWithObjects:localCategory,nil];
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
   /** 根据触发器类型 来判断通知类型 */
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //远程通知处理
        NSLog(@"收到远程通知");
    }else if ([notification.request.trigger isKindOfClass:[UNTimeIntervalNotificationTrigger class]]) {
        //时间间隔触发器通知处理
        NSLog(@"收到本地通知");
    }else if ([notification.request.trigger isKindOfClass:[UNCalendarNotificationTrigger class]]) {
        //日历触发器通知处理
        NSLog(@"收到本地通知");
    }else if ([notification.request.trigger isKindOfClass:[UNLocationNotificationTrigger class]]) {
        //位置触发器通知处理
        NSLog(@"收到本地通知");
    }
    /** 如果不想按照系统的方式展示通知,可以不传入UNNotificationPresentationOptionAlert,自定义弹窗 */
 completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

//用户与通知进行交互后的response，比如说用户直接点开通知打开App、用户点击通知的按钮或者进行输入文本框的文本
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    //在此，可判断response的种类和request的触发器是什么，可根据远程通知和本地通知分别处理，再根据action进行后续回调
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {//远程通知
        //可根据actionIdentifier来做业务逻辑
        if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
            UNTextInputNotificationResponse * textResponse = (UNTextInputNotificationResponse*)response;
            NSString * text = textResponse.userText;
            NSLog(@"回复内容 : %@",text);
        }else{
            if ([response.actionIdentifier isEqualToString:@"remoteAction"]) {
                NSLog(@"点击了处理远程通知按钮");
            }
        }
    }else {//本地通知
        //可根据actionIdentifier来做业务逻辑
        if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
            UNTextInputNotificationResponse * textResponse = (UNTextInputNotificationResponse*)response;
            NSString * text = textResponse.userText;
            NSLog(@"回复内容 : %@",text);
        }else{
            if ([response.actionIdentifier isEqualToString:@"localAction"]) {
                NSLog(@"点击了处理本地通知按钮");
            }
        }
    }
    completionHandler();
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
