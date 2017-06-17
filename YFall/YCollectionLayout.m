//
//  YCollectionLayout.m
//  YFall
//
//  Created by yxf on 2017/6/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YCollectionLayout.h"

@interface YCollectionLayout ()

/** inner space*/
@property(nonatomic,assign)CGFloat innerSpace;

/** line space*/
@property(nonatomic,assign)CGFloat lineSpace;

/** insets*/
@property(nonatomic,assign)UIEdgeInsets insets;

/** row*/
@property(nonatomic,assign)NSInteger row;

/** 坐标信息*/
@property(nonatomic,strong)NSMutableArray<UICollectionViewLayoutAttributes *> *frameAttributes;

/** 每一列的最后一个item的maxY信息*/
@property(nonatomic,strong)NSMutableDictionary *maxYDic;

/** width*/
@property(nonatomic,assign)CGFloat width;

@end

@implementation YCollectionLayout

-(instancetype)initWithRows:(NSInteger)row InnerSpace:(CGFloat)innerSpace lineSpace:(CGFloat)lineSpace sectionInsets:(UIEdgeInsets)insets{
    if (self) {
        _lineSpace = lineSpace;
        _innerSpace = innerSpace;
        _insets = insets;
        _row = row;
    }
    return self;
}

#pragma mark - getter
-(NSMutableArray<UICollectionViewLayoutAttributes *> *)frameAttributes{
    if (!_frameAttributes) {
        _frameAttributes = [NSMutableArray array];
    }
    return _frameAttributes;
}

-(NSMutableDictionary *)maxYDic{
    if (!_maxYDic) {
        _maxYDic = [NSMutableDictionary dictionary];
    }
    return _maxYDic;
}

-(CGFloat)width{
    if (_width <= 0) {
        CGFloat width = CGRectGetWidth(self.collectionView.frame);
        _width = (width - _insets.left - _insets.right - (_row - 1) * _innerSpace) / _row;
    }
    return _width;
}

#pragma mark -supper
-(void)prepareLayout{
    
    //重置每一列的maxY信息
    for (int j=0; j<_row; j++) {
        [self.maxYDic setObject:@0 forKey:@(j)];
    }
    
    //重置每隔item的frame信息
    [self.frameAttributes removeAllObjects];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<itemCount; i++){
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.frameAttributes addObject:attributes];
    }
}

-(CGSize)collectionViewContentSize{
    //这里的direction 是 上下方向的，所以width=0，只需要求height
    __block CGFloat height = 0;
    [self.frameAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat maxY = CGRectGetMaxY(obj.frame);
        if (maxY > height) {
            height = maxY;
        }
    }];
    return CGSizeMake(0, height + _insets.bottom);
}

//核心方法，设置每个item的frame
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取当前最小maxY的列
    __block NSInteger row = 0;
    __block CGFloat minY = [self.maxYDic[@0] floatValue];
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if (obj.floatValue < minY) {
            row = key.integerValue;
            minY = obj.floatValue;
        }
    }];
    
    CGFloat currentY = minY > 0 ? (minY + _lineSpace) : _insets.top;
    CGFloat currentX = _insets.left + (self.width + _innerSpace) * row;
    CGFloat width = self.width;
    CGFloat height = arc4random() % 3 * 40 + 40;
    CGRect currentFrame = CGRectMake(currentX, currentY, width, height);
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = currentFrame;

    //更改当前列的最大MaxY信息
    [self.maxYDic setObject:@(CGRectGetMaxY(currentFrame)) forKey:@(row)];
    
    return attributes;
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.frameAttributes;
}





@end
