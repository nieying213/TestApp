//
//  V2MenuView.m
//  v2ex-iOS
//
//  Created by Singro on 3/18/14.
//  Copyright (c) 2014 Singro. All rights reserved.
//

#import "V2MenuView.h"


@interface V2MenuView ()

@property (nonatomic, strong) UIView      *backgroundContainView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIImageView *leftShadowImageView;
@property (nonatomic, strong) UIView      *leftShdowImageMaskView;

@property (nonatomic, strong) UIView *sectionView;

@end

@implementation V2MenuView

- (void)setX:(CGFloat)newX
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = newX;
    self.frame = newFrame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = NO;
        
        [self configureViews];
        [self configureShadowViews];
        
        
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
    
    self.sectionView = [[UIView alloc] init];
    [self addSubview:self.sectionView];
    
    
}

- (void)configureShadowViews {
    
    self.leftShdowImageMaskView               = [[UIView alloc] init];
    self.leftShdowImageMaskView.clipsToBounds = YES;
    [self addSubview:self.leftShdowImageMaskView];
    
//    UIImage *shadowImage               = [UIImage imageNamed:@"Navi_Shadow"];
//    shadowImage = shadowImage.imageForCurrentTheme;
    
  //  self.leftShadowImageView           = [[UIImageView alloc] initWithImage:shadowImage];
    self.leftShadowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.leftShadowImageView.alpha     = 0.0;
    [self.leftShdowImageMaskView addSubview:self.leftShadowImageView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];;

    self.backgroundContainView.frame  = (CGRect){0, 0, self.frame.size.width, kScreenHeight};
    self.backgroundImageView.frame    = (CGRect){kScreenWidth, 0, kScreenWidth, kScreenHeight};

    self.leftShdowImageMaskView.frame = (CGRect){self.frame.size.width, 0, 10, kScreenHeight};
    self.leftShadowImageView.frame    = (CGRect){-5, 0, 10, kScreenHeight};
    
    self.sectionView.frame  = (CGRect){0, 0, self.frame.size.width, kScreenHeight};
    
}

#pragma mark - Public Methods

- (void)setOffsetProgress:(CGFloat)progress {
    
    progress = MIN(MAX(progress, 0.0), 1.0);
    
   // self.backgroundImageView.frame.s     = self.frame.size.width - kScreenWidth/2 * progress;

    self.leftShadowImageView.alpha = progress;
//    self.leftShadowImageView.x     = -5 + progress * 5;
    
}

- (void)setBlurredImage:(UIImage *)blurredImage {
    _blurredImage = blurredImage;
    
    self.backgroundImageView.image = self.blurredImage;
    
}

- (void)selectIndex:(NSUInteger)index
{
 //   self.sectionView.selectedIndex = index;
}

#pragma mark - Notifications

- (void)didReceiveThemeChangeNotification {
    
    [self setNeedsLayout];
    
    UIImage *shadowImage           = [UIImage imageNamed:@"Navi_Shadow"];
//    shadowImage                    = shadowImage.imageForCurrentTheme;

    self.leftShadowImageView.image = shadowImage;
    self.backgroundImageView.image = nil;

}

@end
