//
//  YCollectionLayout.h
//  YFall
//
//  Created by yxf on 2017/6/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCollectionLayout : UICollectionViewFlowLayout

-(instancetype)initWithRows:(NSInteger)row
                 InnerSpace:(CGFloat)innerSpace
                  lineSpace:(CGFloat)lineSpace
              sectionInsets:(UIEdgeInsets)insets;

@end
