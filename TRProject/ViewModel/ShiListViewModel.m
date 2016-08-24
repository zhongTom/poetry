//
//  ShiListViewModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ShiListViewModel.h"

@implementation ShiListViewModel
- (instancetype)initWithKindModel:(KindModel *)kindModel{
    if (self = [super init]) {
        self.kindModel = kindModel;
    }
    return self;
}
- (instancetype)init{
    NSAssert1(NO, @"%s 必须使用initWithKindModel方法初始化", __FUNCTION__);
    return nil;
}
- (NSInteger)rowNumber{
    return self.shiList.count;
}
- (void)getShiListCompletionHandler:(void (^)())completionHandler{
    [PoetryDBManager getPoetryListWithKind:self.kindModel completionHandler:^(NSArray<ShiModel *> *poetryList) {
        self.shiList = poetryList;
        completionHandler();
    }];
}
- (NSString *)titleForRow:(NSInteger)row{
    return self.shiList[row].title;
}
- (NSString *)authorForRow:(NSInteger)row{
    return self.shiList[row].author;
}
- (ShiModel *)shiForRow:(NSInteger)row{
    return self.shiList[row];
}
- (void)removeShi:(ShiModel *)shi completionHandler:(void (^)())completionHandler{
    [PoetryDBManager removePoetry:shi completionHandler:^(BOOL success) {
        completionHandler();
    }];
}
@end
