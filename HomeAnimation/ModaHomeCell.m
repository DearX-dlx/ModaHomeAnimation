//
//  ModaHomeCell.m
//  HomeAnimation
//
//  Created by DearX on 16/3/27.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "ModaHomeCell.h"

#define CellW self.frame.size.width
#define CellH self.frame.size.height

@implementation ModaHomeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.imageV];
        [self addSubview:self.grayView];
        
        self.clipsToBounds = YES;
        
    }
    return self;
}

#pragma mark - Private Method Area
- (void)scaleNeedCellImageVInCV:(UICollectionView *)cv {

    //NSLog(@"cellFrame:%@",NSStringFromCGRect(self.frame));
    
    //如果cell在cv的上部分就需要调整imageV的位置
    CGFloat line = cv.contentOffset.y + cv.bounds.size.height * 0.5;
    if (self.frame.origin.y < line) {
        //NSLog(@"cellFrame:%@",NSStringFromCGRect(self.frame));
        
        //抵消掉cell的放大效果,因为cell有偏移，imageView没有偏移，所以我们给其d值 * 0.5
        self.imageV.transform = CGAffineTransformMake(1, 0, 0, 1 - (self.transform.d - 1) * 0.5, 0,0);
        
        //灰度效果控制
        self.grayView.alpha = 1 - (self.transform.d - 1);
        
    }else {
        //如果不写这句，就会在复用的时候出现问题
        self.imageV.transform = CGAffineTransformMake(1, 0, 0, 1, 0,0);
    }
}

#pragma mark Lazy Load Area
- (UIImageView *)imageV {

    if (_imageV == nil) {
        
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, - (CellH * 0.5), CellW, CellH * 2)];

    }
    return _imageV;
}

- (UIView *)grayView {

    if (_grayView == nil) {
        _grayView = [[UIView alloc] initWithFrame:self.bounds];
        _grayView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    }
    return _grayView;
}

@end
