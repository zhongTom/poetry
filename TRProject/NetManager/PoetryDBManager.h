//
//  PoetryDBManager.h
//  TRProject
//
//  Created by 钟至大 on 16/8/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShiModel.h"
#import "KindModel.h"
@interface PoetryDBManager : NSObject
/** 查询诗类型列表 */
+ (void)getKindListCompletionHandler:(void(^)(NSArray<KindModel *> *kind))completionHandler;
/** 删除诗词类型 */
+ (void)removeKind:(KindModel *)king completionHandler:(void(^)(BOOL success))completionHandler;
/** 搜索查询操作 */
+ (void)queryPoetryWithWords:(NSString *)words completionHandler:(void(^)(NSArray<ShiModel *> *poetryList))completionHandler;
/** 通过诗的类型获取对应诗词列表 */
+ (void)getPoetryListWithKind:(KindModel *)kind completionHandler:(void(^)(NSArray<ShiModel *> *poetryList))completionHandler;

/** 删除某一首诗 */
+ (void)removePoetry:(ShiModel *)poetry completionHandler:(void(^)(BOOL success))completionHandler;
@end
