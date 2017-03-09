//
//  menuSectionCell.h
//  GestureDemo
//
//  Created by Nie,Ying(MTBD) on 2017/1/17.
//  Copyright © 2017年 Nie,Ying(MTBD). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuSectionCell : UITableViewCell
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *badge;

+ (CGFloat)getCellHeight;
@end
