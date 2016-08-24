//
//  ShiListViewModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PoetryDBManager.h"
@interface ShiListViewModel : NSObject
- (instancetype)initWithKindModel:(KindModel *)kindModel;
@property (nonatomic) KindModel *kindModel;
- (void)getShiListCompletionHandler:(void(^)())completionHandler;
@property (nonatomic) NSArray<ShiModel *> *shiList;
@property (nonatomic) NSInteger rowNumber;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)authorForRow:(NSInteger)row;
- (ShiModel *)shiForRow:(NSInteger)row;
- (void)removeShi:(ShiModel *)shi completionHandler:(void (^)())completionHandler;
@end
