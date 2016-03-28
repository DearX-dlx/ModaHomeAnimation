//
//  ModaHomeLayout.m
//  HomeAnimation
//
//  Created by 来定MAC on 16/3/18.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "ModaHomeLayout.h"

#define CVW self.collectionView.frame.size.width
#define CVH self.collectionView.frame.size.height
#define CELLH CVH * 0.25

@implementation ModaHomeLayout

/**
 *  初始化工作
 */
- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height * 0.25);
    self.minimumLineSpacing = 0;
}

/**
 *  显示的边界发生变化的时候就重新布局
 内部会重新调用prepareLayout和layoutAttributeForElementsInRect方法
 获取所有的cell布局标签
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {

    return YES;
}

/**
 *  设置某一个cell的UICollectionViewLayoutAttributes
 *
 *  @param indexPath
 *
 *  @return
 */
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UICollectionViewLayoutAttributes *attr = [super layoutAttributesForItemAtIndexPath:indexPath];
//    
//    return attr;
//    
//}

/**
 *  返回所有在边界里面的item的布局UICollectionViewLayoutAttributes数据数组
 *
 *  @param rect 边界范围
 *
 *  @return UICollectionViewLayoutAttributes数据数组
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSArray *cellAttrArr = [super layoutAttributesForElementsInRect:rect];
    //cv的上半部分区域内cell都是两倍大
    NSInteger zIndex = 1;
    for (UICollectionViewLayoutAttributes *attr in cellAttrArr) {
        
    
        //0 . 当attr的Y < 屏幕的中线就开始变换
        CGFloat offsetCenterY = self.collectionView.contentOffset.y + CVH * 0.5;
        if (attr.frame.origin.y < offsetCenterY) {
            
            CGFloat chazhi = attr.frame.origin.y - self.collectionView.contentOffset.y - attr.size.height;
            //NSLog(@"%ld变换前差值：%f",(long)attr.indexPath.row,chazhi);
            CGFloat fenmu = CVH * 0.25;
            
            CGFloat rate = chazhi < 0 ? 1 :(1 - chazhi / fenmu);
            //NSLog(@"%ld-rate值：%f",(long)attr.indexPath.row,rate);
            
            attr.transform = CGAffineTransformMake(1, 0, 0,1 + rate, 0,- (attr.size.height * 0.5 * rate));
            
            if (attr.indexPath.row == 0) {
                //如果不隐藏第一个，那么下拉就会看到第一个cell
                attr.hidden = YES;
            }

            
        }
        attr.zIndex = zIndex ++;
    }
    
    return cellAttrArr;
}

/**
 *  用来设置collectionView停止滚动那一刻的位置
 *
 *  @param proposedContentOffset 原本collectionView停止滚动的那一刻位置
 *  @param velocity              滚动数据
 *
 *  @return
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    // 1.计算出scrollView最后会停留的范围
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    // 计算屏幕底部的偏移值
    CGFloat bottomY = proposedContentOffset.y + self.collectionView.frame.size.height;
    
    // 2.取出这个范围内的所有属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    // 获取Y值
    UICollectionViewLayoutAttributes *attr = [array lastObject];
    //NSLog(@"point : %@",attr);
    
    if ((CGRectGetMaxY(attr.frame) - bottomY) > (attr.size.height * 0.5)) {
        
        CGFloat distance = bottomY - attr.frame.origin.y;
        CGFloat endPointY = proposedContentOffset.y - distance;
        return CGPointMake(proposedContentOffset.x, endPointY);
    }else {
    
        CGFloat distance = CGRectGetMaxY(attr.frame) - bottomY;
        CGFloat endPointY = proposedContentOffset.y + distance;
        
        //如果超过了collection的边界，那么停在最大的边界处
        if ((endPointY + CVH) > self.collectionView.contentSize.height) {
            return CGPointMake(proposedContentOffset.x, self.collectionView.contentSize.height - CVH);
        }else{return CGPointMake(proposedContentOffset.x, endPointY);}
        
    }
    
}

@end
