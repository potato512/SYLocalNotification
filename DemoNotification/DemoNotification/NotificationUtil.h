//
//  NotificationUtil.h
//  DemoNotification
//
//  Created by zhangshaoyu on 2020/4/15.
//  Copyright © 2020 devZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationUtil : NSObject

+ (void)addNotificationMessage:(NSString *)message;

+ (void)removeNotification;

@end

NS_ASSUME_NONNULL_END
