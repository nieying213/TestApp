//
//  menuView.m
//  GestureDemo
//
//  Created by Nie,Ying(MTBD) on 2017/1/17.
//  Copyright © 2017年 Nie,Ying(MTBD). All rights reserved.
//

#import "menuView.h"
#import "menuSectionView.h"
#import "UIImage+Tint.h"

@interface menuView ()
@property (nonatomic, strong) UIView      *backgroundContainView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIImageView *leftShadowImageView;
@property (nonatomic, strong) UIView      *leftShdowImageMaskView;

@property (nonatomic, strong) menuSectionView *sectionView;

@end

@implementation menuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = NO;
        
        [self configureViews];
        [self configureShadowViews];
        
       // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveThemeChangeNotification) name:kThemeDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configureViews {
    
    self.backgroundContainView               = [[UIView alloc] init];
    self.backgroundContainView.clipsToBounds = YES;
    [self addSubview:self.backgroundContainView];
    
    self.backgroundImageView = [[UIImageView alloc] init];
    [self.backgroundContainView addSubview:self.backgroundImageView];
    
    self.sectionView = [[menuSectionView alloc] init];
    [self addSubview:self.sectionView];
    
    // Handles
//    @weakify(self);
//    [self.sectionView setDidSelectedIndexBlock:^(NSInteger index) {
//        @strongify(self);
//        
//        if (self.didSelectedIndexBlock) {
//            self.didSelectedIndexBlock(index);
//        }
//        
//    }];
    
}

- (void)configureShadowViews {
    
    self.leftShdowImageMaskView               = [[UIView alloc] init];
    self.leftShdowImageMaskView.clipsToBounds = YES;
    [self addSubview:self.leftShdowImageMaskView];
    
    UIImage *shadowImage               = [UIImage imageNamed:@"Navi_Shadow"];
 //   shadowImage = shadowImage.imageForCurrentTheme;
    
    self.leftShadowImageView           = [[UIImageView alloc] initWithImage:shadowImage];
    self.leftShadowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.leftShadowImageView.alpha     = 0.0;
    [self.leftShdowImageMaskView addSubview:self.leftShadowImageView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = kBackgroundColorWhiteDark;
    
    self.backgroundContainView.frame  = (CGRect){0, 0, self.frame.size.width, kScreenHeight};
    self.backgroundImageView.frame    = (CGRect){kScreenWidth, 0, kScreenWidth, kScreenHeight};
    
    self.leftShdowImageMaskView.frame = (CGRect){self.frame.size.width, 0, 10, kScreenHeight};
    self.leftShadowImageView.frame    = (CGRect){-5, 0, 10, kScreenHeight};
    
    self.sectionView.frame  = (CGRect){0, 0, self.frame.size.width, kScreenHeight};
    
}

#pragma mark - Public Methods

- (void)setOffsetProgress:(CGFloat)progress {
    
    progress = MIN(MAX(progress, 0.0), 1.0);
    
    self.backgroundImageView.x     = self.frame.size.width - kScreenWidth/2 * progress;
    
    self.leftShadowImageView.alpha = progress;
    self.leftShadowImageView.x     = -5 + progress * 5;
    
}

- (void)setBlurredImage:(UIImage *)blurredImage {
    _blurredImage = blurredImage;
    
    self.backgroundImageView.image = self.blurredImage;
    
}

- (void)selectIndex:(NSUInteger)index
{
    self.sectionView.selectedIndex = index;
}

#pragma mark - Notifications

- (void)didReceiveThemeChangeNotification {
    
    [self setNeedsLayout];
    
    UIImage *shadowImage           = [UIImage imageNamed:@"Navi_Shadow"];
    shadowImage                    = shadowImage.imageForCurrentTheme;
    
    self.leftShadowImageView.image = shadowImage;
    self.backgroundImageView.image = nil;
    
}

@end
