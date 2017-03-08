//
//  ViewController.m
//  ceshi
//
//  Created by Nie,Ying(MTBD) on 2016/12/26.
//  Copyright © 2016年 Nie,Ying(MTBD). All rights reserved.
//

#import "ViewController.h"
#import "V2MenuView.h"

static CGFloat const kMenuWidth = 240.0;

//kScreenWidth ([UIScreen mainScreen].bounds.size.width)
@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) V2MenuView *menuView;
@property (nonatomic, strong) UIView *viewControllerContainView;

@property (nonatomic, strong) UIButton   *rootBackgroundButton;
@property (nonatomic, strong) UIImageView *rootBackgroundBlurView;
//@property (nonatomic, strong) UIView     *naviBottomLineView;

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePanRecognizer;

@property (nonatomic, assign) NSInteger currentSelectedIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rootBackgroundButton.frame = self.view.frame;
    [self configureViews];
    [self configureGestures];
 //   ndsfhsdfsdfds
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(done) name:@"NotificationTest" object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)configureViews {
    
    
    self.rootBackgroundButton               = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rootBackgroundButton.backgroundColor = [UIColor redColor];
    self.rootBackgroundButton.alpha = 0.0;
    self.rootBackgroundButton.backgroundColor = [UIColor redColor];
    self.rootBackgroundButton.hidden = YES;
    [self.view addSubview:self.rootBackgroundButton];
    
    self.menuView                           = [[V2MenuView alloc] initWithFrame:(CGRect){-kMenuWidth, 0, kMenuWidth, kScreenHeight}];
    self.menuView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.menuView];
    
}



- (void)configureGestures {
    
    self.edgePanRecognizer          = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePanRecognizer:)];
    self.edgePanRecognizer.edges    = UIRectEdgeLeft;
    self.edgePanRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.edgePanRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    panRecognizer.delegate = self;
    [self.rootBackgroundButton addGestureRecognizer:panRecognizer];
    
}

- (void)handlePanRecognizer:(UIPanGestureRecognizer *)recognizer {
    
    CGFloat progress = [recognizer translationInView:self.rootBackgroundButton].x / (self.rootBackgroundButton.bounds.size.width * 0.5);
    progress = - MIN(progress, 0);
    
    [self setMenuOffset:kMenuWidth - kMenuWidth * progress];
    
    static CGFloat sumProgress = 0;
    static CGFloat lastProgress = 0;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        sumProgress = 0;
        lastProgress = 0;
        
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        if (progress > lastProgress) {
            sumProgress += progress;
        } else {
            sumProgress -= progress;
        }
        lastProgress = progress;
        
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.3 animations:^{
            if (sumProgress > 0.1) {
                [self setMenuOffset:0];
            } else {
                [self setMenuOffset:kMenuWidth];
            }
        } completion:^(BOOL finished) {
            if (sumProgress > 0.1) {
                self.rootBackgroundButton.hidden = YES;
            } else {
                self.rootBackgroundButton.hidden = NO;
            }
        }];
    }
    
}

- (void)handleEdgePanRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / kMenuWidth;
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        //        [self setBlurredScreenShoot];
        self.rootBackgroundButton.hidden = NO;
        
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [self setMenuOffset:kMenuWidth * progress];
        
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        
        CGFloat velocity = [recognizer velocityInView:self.view].x;
        
        if (velocity > 20 || progress > 0.5) {
            
            [UIView animateWithDuration:(1-progress)/1.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:3.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                [self setMenuOffset:kMenuWidth];
            } completion:^(BOOL finished) {
                ;
            }];
        }
        else {
            [UIView animateWithDuration:progress/3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self setMenuOffset:0];
            } completion:^(BOOL finished) {
                self.rootBackgroundButton.hidden = YES;
                self.rootBackgroundButton.alpha = 0.0;
            }];
        }
        
    }
    
}

- (void)setMenuOffset:(CGFloat)offset {
    
    self.menuView.x = offset - kMenuWidth;
    [self.menuView setOffsetProgress:offset/kMenuWidth];
    self.rootBackgroundButton.alpha = offset/kMenuWidth * 0.3;
    
}



-(void)done
{
    NSLog(@"hello world");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
