//
//  ShiModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShiModel : NSObject
@property (nonatomic) NSString *shi;
@property (nonatomic) NSString *introShi;
@property (nonatomic) NSString *author;
@property (nonatomic) NSString *kind;
@property (nonatomic) NSInteger Id;
@property (nonatomic) NSString *title;
+ (ShiModel *)parse:(FMResultSet *)result;
@end
