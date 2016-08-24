//
//  PoetryDBManager.m
//  TRProject
//
//  Created by 钟至大 on 16/8/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoetryDBManager.h"

@implementation PoetryDBManager

+ (void)getKindListCompletionHandler:(void (^)(NSArray<KindModel *> *))completionHandler{
    //查询操作是耗时操作，放到多线程中执行
    [[NSOperationQueue new]addOperationWithBlock:^{
        FMDatabase *db = [FMDatabase databaseWithPath:kAppdelegate.dbPath];
        [db open];
        FMResultSet *resultSet = [db executeQuery:@"select * from T_KIND"];
        NSMutableArray *tmpArr = [NSMutableArray new];
        while ([resultSet next]) {
            [tmpArr addObject:[KindModel parse:resultSet]];
        }
        [db close];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            completionHandler(tmpArr);
        }];
    }];
}
+ (void)removeKind:(KindModel *)king completionHandler:(void (^)(BOOL))completionHandler{
    FMDatabase *db = [FMDatabase databaseWithPath:kAppdelegate.dbPath];
    NSLog(@"%@",[db open]?@"打开数据库":@"打开失败");
    [[NSOperationQueue new]addOperationWithBlock:^{
        BOOL success = [db executeUpdateWithFormat:@"delete from T_KIND where D_KIND=%@",king.kind];
        if (success) {
            success = [db executeUpdateWithFormat:@"delete from T_SHI where D_KIND=%@",king.kind];
            if (!success) {
                [db rollback];
            }
        }
        [db close];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            completionHandler(success);
        }];
    }];
}
+ (void)queryPoetryWithWords:(NSString *)words completionHandler:(void (^)(NSArray<ShiModel *> *))completionHandler{
    FMDatabase *db = [FMDatabase databaseWithPath:kAppdelegate.dbPath];
    NSLog(@"%@",[db open]?@"打开数据库":@"打开失败");
    [[NSOperationQueue new]addOperationWithBlock:^{
        NSString *searchWord = [NSString stringWithFormat:@"%%%@%%",words];
        FMResultSet *result = [db executeQueryWithFormat:@"select * from T_SHI where D_SHI like %@ or D_AUTHOR like %@ or D_TITLE like %@",searchWord,searchWord,searchWord];
        NSMutableArray *arr = [NSMutableArray new];
        while ([result next]) {
            [arr addObject:[ShiModel parse:result]];
        }
        [db close];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            completionHandler(arr);
        }];
    }];
}
+ (void)getPoetryListWithKind:(KindModel *)kind completionHandler:(void (^)(NSArray<ShiModel *> *))completionHandler{
    FMDatabase *db = [FMDatabase databaseWithPath:kAppdelegate.dbPath];
     NSLog(@"%@",[db open]?@"打开数据库":@"打开失败");
    [[NSOperationQueue new]addOperationWithBlock:^{
        FMResultSet *result = [db executeQueryWithFormat:@"select * from T_SHI where D_KIND=%@",kind.kind];
        NSMutableArray *arr = [NSMutableArray new];
        while ([result next]) {
            [arr addObject:[ShiModel parse:result]];
        }
        [db close];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            completionHandler(arr);
        }];
    }];
}

+ (void)removePoetry:(ShiModel *)poetry completionHandler:(void (^)(BOOL))completionHandler{
    FMDatabase *db = [FMDatabase databaseWithPath:kAppdelegate.dbPath];
    NSLog(@"%@",[db open]?@"打开数据库":@"打开失败");
    [[NSOperationQueue new]addOperationWithBlock:^{
        BOOL success = [db executeUpdateWithFormat:@"delete from T_SHI where D_ID=%ld",poetry.Id];
        [db close];
        completionHandler(success);
    }];
}


@end
