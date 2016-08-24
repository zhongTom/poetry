//
//  KindModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "KindModel.h"

@implementation KindModel
+ (KindModel *)parse:(FMResultSet *)result{
    KindModel *model = [self new];
    model.kind = [result stringForColumn:@"D_KIND"];
    model.num = [result intForColumn:@"D_NUM"];
    model.introKind = [result stringForColumn:@"D_INTROKIND"];
    model.introKind2 = [result stringForColumn:@"D_INTROKIND2"];
    return  model;
}
@end
