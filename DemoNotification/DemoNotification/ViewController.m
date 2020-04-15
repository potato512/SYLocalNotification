//
//  ViewController.m
//  DemoNotification
//
//  Created by zhangshaoyu on 2020/4/15.
//  Copyright © 2020 devZhang. All rights reserved.
//

#import "ViewController.h"
#import "NotificationUtil.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"本地通知";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"text" style:UIBarButtonItemStyleDone target:self action:@selector(buttonClick)];
}

- (void)buttonClick
{
    NSString *text = self.array[arc4random() % self.array.count];
    [NotificationUtil addNotificationMessage:text];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSString *text = self.array[arc4random() % self.array.count];
//        [NotificationUtil addNotificationMessage:text];
//    });
}

- (NSArray *)array
{
    if (_array == nil) {
        _array = @[@"在iOS10上苹果将原来散落在UIKit中各处的用户通知相关的代码进行重构，剥离打造了一个全新的通知框架-UserNotifications，因公司业务需求,对这方面做了一些研究。总结此文", @"总结此文", @"本文用到的远程推送工具PushMeBaby,也在上篇文章中。", @"在iOS10上苹果推送。"];
    }
    return _array;
}

@end
