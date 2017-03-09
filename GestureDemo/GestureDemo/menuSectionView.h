//
//  menuSectionView.h
//  GestureDemo
//
//  Created by Nie,Ying(MTBD) on 2017/1/17.
//  Copyright © 2017年 Nie,Ying(MTBD). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuSectionView : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^didSelectedIndexBlock)(NSInteger index);

- (void)setDidSelectedIndexBlock:(void (^)(NSInteger index))didSelectedIndexBlock;


@end
