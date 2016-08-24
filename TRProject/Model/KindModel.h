//
//  KindModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KindModel : NSObject
@property (nonatomic) NSString *kind;
@property (nonatomic) NSInteger num;
@property (nonatomic) NSString *introKind;
@property (nonatomic) NSString *introKind2;
+ (KindModel *)parse:(FMResultSet *)result;
@end
