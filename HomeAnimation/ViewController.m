//
//  ViewController.m
//  HomeAnimation
//
//  Created by 来定MAC on 16/3/18.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "ViewController.h"
#import "ModaHomeLayout.h"
#import "ModaHomeCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, strong) NSMutableArray *mainDataArrM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.mainView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - datasource Area

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.mainDataArrM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"cellID";
    ModaHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.imageV.image = [self.mainDataArrM objectAtIndex:indexPath.row];
    //默认抵消掉cell的放大效果，如果不写，那么第二个cell的imageV就默认被放大了
    [cell scaleNeedCellImageVInCV:collectionView];
    return cell;
}

#pragma mark - Delegate Area

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSArray<ModaHomeCell *> *array = [self.mainView visibleCells];
    //NSLog(@"遍历开始");
    for (ModaHomeCell *cell in array) {
        
        [cell scaleNeedCellImageVInCV:self.mainView];
    }
    //NSLog(@"遍历结束");
}

#pragma mark - lazy load Area

- (UICollectionView *)mainView {

    if (_mainView == nil) {
        
        ModaHomeLayout *flowLayout = [[ModaHomeLayout alloc] init];
        _mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:flowLayout];
        _mainView.backgroundColor = [UIColor blackColor];
        _mainView.delegate = self;
        _mainView.dataSource = self;
        
        [_mainView registerClass:[ModaHomeCell class] forCellWithReuseIdentifier:@"cellID"];
    }
    return _mainView;
}

- (NSMutableArray *)mainDataArrM {

    if (_mainDataArrM == nil) {
        _mainDataArrM = [NSMutableArray array];
        for (NSInteger i = 1; i < 9; i ++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"home0%ld",(long)i]];
            [_mainDataArrM addObject:image];
        }
    }
    return _mainDataArrM;
}

@end
