//
//  AppDelegate.h
//  TRProject
//
//  Created by jiyingxin on 16/2/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//


#import <AFNetworkReachabilityManager.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, getter=isOnLine) BOOL onLine;
@property (nonatomic) AFNetworkReachabilityStatus netReachStatus;
//数据库在沙盒中的路径
@property (nonatomic) NSString *dbPath;
@end

