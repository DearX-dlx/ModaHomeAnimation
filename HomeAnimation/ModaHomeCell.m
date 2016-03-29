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

#define NameFont 22

@implementation ModaHomeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.imageV];
        [self addSubview:self.grayView];
        [self addSubview:self.name_L];
        [self addSubview:self.namEng_L];
        
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
        
        //设置名字的展示效果，只有当视图变大到1.5倍的时候name才有变换(使用变换会使字体变模糊，所以使用改变字体)
        //抵消cell的变换
        self.name_L.transform = CGAffineTransformMake(1, 0, 0, 1- (self.transform.d - 1) * 0.5 , 0, 0);
        if (self.transform.d > 1.5) {
            //这里变换需要先抵消cell的变换，然后控制自己的变换
            //self.name_L.transform = CGAffineTransformMake(1 + (self.transform.d - 1.5), 0, 0, ((1- (self.transform.d - 1) * 0.5) + (self.transform.d - 1.5)), 0, 0);
            CGFloat fontSize = (self.transform.d - 1.5) * 10 + NameFont;
            self.name_L.font = [UIFont systemFontOfSize:fontSize];
        }else {
            self.name_L.font = [UIFont systemFontOfSize:NameFont];
        }
        
        //设置英文名字的展示效果，只有当在这个视图范围内，小于1.5倍的时候englishname才有变换
        //抵消cell的变换
        self.namEng_L.transform = CGAffineTransformMake(1, 0, 0, 1 - (self.transform.d - 1) * 0.5, 0,0);
        if (self.transform.d < 1.5) {
            //这里变换需要先抵消cell的变换，然后控制自己的变换
            self.namEng_L.alpha = 1 - ((1.5 - self.transform.d) * 2);
        }else {
            
            self.namEng_L.alpha = 1;
        }
        
        //灰度效果控制
        self.grayView.alpha = 1 - (self.transform.d - 1);
        
    }else {
        //如果不写这句，就会在复用的时候出现问题
        self.imageV.transform = CGAffineTransformMake(1, 0, 0, 1, 0,0);
        self.name_L.transform = CGAffineTransformMake(1, 0, 0, 1, 0,0);
        self.namEng_L.alpha = 0;
        self.name_L.font = [UIFont systemFontOfSize:NameFont];
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

- (UILabel *)name_L {

    if (_name_L == nil) {
        CGFloat h = 21;
        _name_L = [[UILabel alloc] initWithFrame:CGRectMake(0, CellH * 0.5 - h, CellW, h)];
        //_name_L.backgroundColor = [UIColor redColor];
        _name_L.textAlignment = NSTextAlignmentCenter;
        _name_L.textColor = [UIColor whiteColor];
        _name_L.font = [UIFont systemFontOfSize:NameFont];
        _name_L.text = @"高级定制";
    }
    return _name_L;
}

- (UILabel *)namEng_L {

    if (_namEng_L == nil) {
        CGFloat h = 21;
        _namEng_L = [[UILabel alloc] initWithFrame:CGRectMake(0, CellH * 0.5 - 5,CellW, h)];
        //_namEng_L.backgroundColor = [UIColor greenColor];
        _namEng_L.textAlignment = NSTextAlignmentCenter;
        _namEng_L.textColor = [UIColor whiteColor];
        _namEng_L.text = @"ADVANCED CUSTOMIZATION";
        _namEng_L.alpha = 0;
    }
    return _namEng_L;
}

@end
