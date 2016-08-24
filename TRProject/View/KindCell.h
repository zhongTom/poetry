//
//  KindCell.h
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KindCell;
@protocol KindCellDelegate <NSObject>
- (void)removeKindInCell:(KindCell *)kindCell;


@end
@interface KindCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (nonatomic,weak) id<KindCellDelegate> delegate;
@end
