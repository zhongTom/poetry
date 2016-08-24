//
//  KindViewModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PoetryDBManager.h"
@interface KindViewModel : NSObject
//搜索功能
@property (nonatomic) NSArray<ShiModel *> *resultList;
- (void)searchWithWords:(NSString *)words completionHandler:(void(^)())completionHandler;
@property (nonatomic) NSInteger shiNumber;
- (NSString *)shiTitleForRow:(NSInteger)row;
- (NSString *)authorForRow:(NSInteger)row;
- (ShiModel *)shiForRow:(NSInteger)row;
@property(nonatomic) NSInteger rowNumber;
- (NSString *)titleForRow:(NSInteger)row;
- (KindModel *)kindForRow:(NSInteger)row;

//删除某个类型
- (void)removeKind:(KindModel *)kind completionHandler:(void(^)())completionHandler;

/** 获取诗类型列表 */
- (void)getKindListCompletionHandler:(void(^)())completionHandler;
@property(nonatomic) NSArray *kindList;
@end
