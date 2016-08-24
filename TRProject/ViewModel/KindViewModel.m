//
//  KindViewModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "KindViewModel.h"

@implementation KindViewModel
//搜索功能
- (NSInteger)shiNumber{
    return self.resultList.count;
}
- (ShiModel *)shiForRow:(NSInteger)row{
    return self.resultList[row];
}
- (NSString *)shiTitleForRow:(NSInteger)row{
    return [self shiForRow:row].title;
}
- (NSString *)authorForRow:(NSInteger)row{
    return [self shiForRow:row].author;
}
- (void)searchWithWords:(NSString *)words completionHandler:(void (^)())completionHandler{
    [PoetryDBManager queryPoetryWithWords:words completionHandler:^(NSArray<ShiModel *> *poetryList) {
        self.resultList = poetryList;
        completionHandler();
    }];
}
//诗集
- (NSInteger)rowNumber{
    return self.kindList.count;
}
- (KindModel *)kindForRow:(NSInteger)row{
    return self.kindList[row];
}
- (NSString *)titleForRow:(NSInteger)row{
    return [self kindForRow:row].kind;
}
- (void)removeKind:(KindModel *)kind completionHandler:(void (^)())completionHandler{
    [PoetryDBManager removeKind:kind completionHandler:^(BOOL success) {
        completionHandler();
    }];
}
- (void)getKindListCompletionHandler:(void (^)())completionHandler{
    [PoetryDBManager getKindListCompletionHandler:^(NSArray<KindModel *> *kind) {
        self.kindList = kind;
        completionHandler();
    }];
}
@end
