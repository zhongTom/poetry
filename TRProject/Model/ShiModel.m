//
//  ShiModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ShiModel.h"

@implementation ShiModel
+ (ShiModel *)parse:(FMResultSet *)result{
    ShiModel *model = [ShiModel new];
    model.shi = [result stringForColumn:@"D_SHI"];
    model.introShi = [result stringForColumn:@"D_INTROSHI"];
    model.author = [result stringForColumn:@"D_AUTHOR"];
    model.Id = [result intForColumn:@"D_ID"];
    model.kind = [result stringForColumn:@"D_KIND"];
    model.title = [result stringForColumn:@"D_TITLE"];
    return model;
}
@end
