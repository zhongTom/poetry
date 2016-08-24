//
//  AppDelegate.m
//  TRProject
//
//  Created by jiyingxin on 16/2/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+System.h"
#import "PoetryDBManager.h"
#import <UIColor+FlatUI.h>
#warning db文件不能直接拖入项目，会找不到路径，必须放在文件夹中，并且改文件夹后缀名为bundle才可以
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //全局默认配置
    [self setupGlobalConfig];
    [self setUpDataBaseFile];
    [self configGlobalUI];
    NSLog(@"%@",self.dbPath);
    return YES;
}

- (void)configGlobalUI{
    //把图片上的颜色取下来
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    [UICollectionView appearance].backgroundColor = [UIColor clearColor];
    [UITableView appearance].backgroundColor = [UIColor clearColor];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"背景"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexCode:@"534430"],NSFontAttributeName:[UIFont systemFontOfSize:22]}];
    [[UITableView appearance]setSeparatorColor:[UIColor colorFromHexCode:@"9c896f"]];
    [[UIBarButtonItem appearance]setTintColor:[UIColor colorFromHexCode:@"726754"]];
}

- (NSString *)dbPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"db.sqlite"];
}

/* 对数据库要做删除操作,而ipa文件夹下的内容都是只读的，需要将文件拷贝一份到document文件夹下 */
- (void)setUpDataBaseFile{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Poetry.bundle/sqlite.db" ofType:nil];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:self.dbPath]) {
        [manager copyItemAtPath:path toPath:self.dbPath error:nil];
        NSLog(@"%@",self.dbPath);
    }
}
@end
