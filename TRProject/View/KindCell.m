//
//  KindCell.m
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "KindCell.h"

@implementation KindCell
- (IBAction)removeKind:(id)sender {
    if([self.delegate respondsToSelector:@selector(removeKindInCell:)]){
        [self.delegate removeKindInCell:self];
    }
}

@end
