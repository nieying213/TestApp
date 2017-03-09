//
//  menuView.h
//  GestureDemo
//
//  Created by Nie,Ying(MTBD) on 2017/1/17.
//  Copyright © 2017年 Nie,Ying(MTBD). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuView : UIView
@property (nonatomic, copy) void (^didSelectedIndexBlock)(NSInteger index);

- (void)setDidSelectedIndexBlock:(void (^)(NSInteger index))didSelectedIndexBlock;
- (void)selectIndex:(NSUInteger)index;


@property (nonatomic, strong) UIImage *blurredImage;

- (void)setOffsetProgress:(CGFloat)progress;

@end
