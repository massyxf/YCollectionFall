//
//  ViewController.m
//  YFall
//
//  Created by yxf on 2017/6/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "ViewController.h"
#import "YCollectionLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YCollectionLayout *layout = [[YCollectionLayout alloc] initWithRows:3
                                                             InnerSpace:5
                                                              lineSpace:5
                                                          sectionInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    [collectionView registerClass:[UICollectionViewCell class]
       forCellWithReuseIdentifier:@"UICollectionViewCell"];
    collectionView.backgroundColor = [UIColor whiteColor];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UIColor *color = indexPath.item % 2 ? [UIColor redColor] : [UIColor blueColor];
    cell.contentView.backgroundColor = color;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}


@end
