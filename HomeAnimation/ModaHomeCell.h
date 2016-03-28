//
//  ModaHomeCell.h
//  HomeAnimation
//
//  Created by DearX on 16/3/27.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModaHomeCell : UICollectionViewCell

/* 图片空间*/
@property (nonatomic, strong) UIImageView *imageV;
/* 灰度蒙版*/
@property (nonatomic, strong) UIView *grayView;

- (void)scaleNeedCellImageVInCV:(UICollectionView *)cv;

@end
